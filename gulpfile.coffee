{APP_NAME, BOWER_COMPONENTS, SCRIPTS, STYLES} = require './config.coffee'

BOWER_DIRECTORY       = '.components/'
CHANGELOG_FILE        = 'CHANGELOG.md'
COMPONENTS_DIRECTORY  = "#{BOWER_DIRECTORY}_/"
DIST_DIRECTORY        = 'dist/'
DOCS_DIRECTORY        = 'docs/'
E2E_DIRECTORY         = 'e2e/'
FONTS_DIRECTORY       = 'fonts/'
PORT                  = 8181
SCRIPTS_MIN_DIRECTORY = 'scripts/'
SCRIPTS_MIN_FILE      = 'scripts.min.js'
SRC_DIRECTORY         = 'src/'
STYLES_MIN_DIRECTORY  = 'styles/'
STYLES_MIN_FILE       = 'styles.min.css'
TEMP_DIRECTORY        = '.temp/'
VENDOR_DIRECTORY      = 'vendor/'

VIEWS =  [
	'**/*.html'
	'!index.html'
]

bower                 = require 'bower'
buster                = require 'gulp-buster'
childProcess          = require 'child_process'
clean                 = require 'gulp-clean'
coffee                = require 'gulp-coffee'
coffeeLint            = require 'gulp-coffeelint'
concat                = require 'gulp-concat'
connect               = require 'gulp-connect'
conventionalChangelog = require 'conventional-changelog'
es                    = require 'event-stream'
filter                = require 'gulp-filter'
flatten               = require 'gulp-flatten'
fs                    = require 'fs'
gulp                  = require 'gulp'
gutil                 = require 'gulp-util'
jade                  = require 'gulp-jade'
karma                 = require 'karma'
less                  = require 'gulp-less'
markdown              = require 'gulp-markdown'
minifyCss             = require 'gulp-minify-css'
minifyHtml            = require 'gulp-minify-html'
ngClassify            = require 'gulp-ng-classify'
open                  = require 'gulp-open'
path                  = require 'path'
pkg                   = require './package.json'
protractor            = require 'gulp-protractor'
q                     = require 'q'
rev                   = require 'gulp-rev'
template              = require 'gulp-template'
templateCache         = require 'gulp-angular-templatecache'
typeScript            = require 'gulp-typescript'
uglify                = require 'gulp-uglify'

appUrl = "http://localhost:#{PORT}"

bowerComponents = do ->
	components = {}

	for component, value of BOWER_COMPONENTS
		for version, componentTypes of value
			for componentType, files of componentTypes
				isArray = Array.isArray files
				filesToAdd = if isArray then files else [files]

				filesToAdd = filesToAdd.map (file) ->
					path.join component, file

				key = path.join component, componentType

				if not components[key]
					components[key] = []

				components[key] = components[key].concat filesToAdd

	components

env       = gutil.env
isProd    = env.prod? or env.production?
isWindows = /^win/.test(process.platform)

onError = (e) ->
	isArray  = Array.isArray e
	err      = e.message or e
	errors   = if isArray then err else [err]
	messages = (error for error in errors)

	gutil.log gutil.colors.red message for message in messages
	@emit 'end'

processCoffeeScript = ->
	deferred = q.defer()

	options =
		coffeeScript:
			sourceMap: true
		coffeeLint:
			arrow_spacing:
				level: 'error'
			indentation:
				value: 1
			max_line_length:
				level: 'ignore'
			no_tabs:
				level: 'ignore'
		ngClassify:
			appName: APP_NAME or 'app'
			data:
				isProd: isProd

	sources = ['**/*.coffee']

	if isProd
		sources.push '!**/*.spec.coffee'
		sources.push '!**/*.backend.coffee'

	gulp
		.src sources, cwd: TEMP_DIRECTORY
		.pipe coffeeLint options.coffeeLint
		.on 'error', onError
		.pipe coffeeLint.reporter()
		.on 'error', onError
		.on 'end', -> gutil.log 'scripts: CoffeeScript linting complete'
		.pipe ngClassify options.ngClassify
		.on 'error', onError
		.on 'end', -> gutil.log 'scripts: ng-classify complete'
		.pipe coffee options.coffeeScript
		.on 'error', onError
		.pipe gulp.dest TEMP_DIRECTORY
		.on 'end', ->
			gutil.log 'scripts: CoffeeScript compilation complete'
			deferred.resolve()

	deferred.promise

processCss = ->
	deferred = q.defer()

	options =
		keepSpecialComments: 0

	sources = STYLES

	optimizedStylesSource = if isProd then sources else []
	optimizedStylesFilter = filter optimizedStylesSource

	destinationDirectory = if isProd then path.join(DIST_DIRECTORY, STYLES_MIN_DIRECTORY) else DIST_DIRECTORY

	gulp
		.src sources, cwd: TEMP_DIRECTORY

		.pipe optimizedStylesFilter
		.pipe concat STYLES_MIN_FILE
		.on 'error', onError
		.on 'end', -> gutil.log 'styles: Concatenation complete' if isProd
		.pipe minifyCss options
		.on 'error', onError
		.on 'end', -> gutil.log 'styles: Minification complete' if isProd
		.pipe rev()
		.on 'error', onError
		.on 'end', -> gutil.log 'styles: Hashing complete'
		.pipe optimizedStylesFilter.restore()

		.pipe gulp.dest destinationDirectory
		.on 'end', ->
			gutil.log 'styles: CSS processing complete'
			deferred.resolve()

	deferred.promise

processJade = ->
	deferred = q.defer()

	options =
		pretty: true

	gulp
		.src '**/*.jade', cwd: TEMP_DIRECTORY
		.pipe jade options
		.on 'error', onError
		.pipe gulp.dest TEMP_DIRECTORY
		.on 'end', ->
			gutil.log 'views: Jade compilation complete'
			deferred.resolve()

	deferred.promise

processJavaScript = ->
	deferred = q.defer()

	sources = SCRIPTS

	if isProd
		sources.push '!**/*.spec.js'
		sources.push '!**/*.backend.js'
		sources.push '!**/angular-mocks.js'

	optimizedScriptsSource = if isProd then sources else []
	optimizedScriptsFilter = filter optimizedScriptsSource

	destinationDirectory = if isProd then path.join(DIST_DIRECTORY, SCRIPTS_MIN_DIRECTORY) else DIST_DIRECTORY

	gulp
		.src sources, cwd: TEMP_DIRECTORY

		.pipe optimizedScriptsFilter
		.pipe concat SCRIPTS_MIN_FILE
		.on 'error', onError
		.on 'end', -> gutil.log 'scripts: Concatenation complete' if isProd
		.pipe uglify()
		.on 'error', onError
		.on 'end', -> gutil.log 'scripts: Minification complete' if isProd
		.pipe rev()
		.on 'error', onError
		.on 'end', -> gutil.log 'scripts: Hashing complete'
		.pipe optimizedScriptsFilter.restore()
		.pipe gulp.dest destinationDirectory
		.on 'end', ->
			gutil.log 'scripts: JavaScript processing complete'
			deferred.resolve()

	deferred.promise

processLess = ->
	deferred = q.defer()

	options =
		sourceMap: true
		sourceMapBasepath: path.resolve TEMP_DIRECTORY

	gulp
		.src '**/*.less', cwd: TEMP_DIRECTORY
		.pipe less options
		.on 'error', onError
		.pipe gulp.dest TEMP_DIRECTORY
		.on 'end', ->
			gutil.log 'styles: Less compilation complete'
			deferred.resolve()

	deferred.promise

processMarkdown = ->
	deferred = q.defer()

	gulp
		.src '**/*.{md,markdown}', cwd: TEMP_DIRECTORY
		.pipe markdown()
		.on 'error', onError
		.pipe gulp.dest TEMP_DIRECTORY
		.on 'end', ->
			gutil.log 'views: Markdown compilation complete'
			deferred.resolve()

	deferred.promise

processSourceScripts = ->
	deferred = q.defer()

	return deferred.resolve() if isProd

	gulp
		.src '**/*.{coffee,ts,js.map}', cwd: TEMP_DIRECTORY
		.pipe gulp.dest DIST_DIRECTORY
		.on 'end', ->
			gutil.log 'scripts: source files moved'
			deferred.resolve()

	deferred.promise

processSourceStyles = ->
	deferred = q.defer()

	return deferred.resolve() if isProd

	gulp
		.src '**/*.less', cwd: TEMP_DIRECTORY
		.pipe gulp.dest DIST_DIRECTORY
		.on 'end', ->
			gutil.log 'styles: source files moved'
			deferred.resolve()

	deferred.promise

processSourceViews = ->
	deferred = q.defer()

	return deferred.resolve() if isProd

	gulp
		.src '**/*.{jade,md,markdown}', cwd: TEMP_DIRECTORY
		.pipe gulp.dest DIST_DIRECTORY
		.on 'end', ->
			gutil.log 'scripts: source files moved'
			deferred.resolve()

	deferred.promise

processTypeScript = ->
	deferred = q.defer()

	sources = ['**/*.ts']

	if isProd
		sources.push '!**/*.spec.ts'
		sources.push '!**/*.backend.ts'

	gulp
		.src sources, cwd: TEMP_DIRECTORY
		.pipe typeScript()
		.on 'error', onError
		.pipe gulp.dest TEMP_DIRECTORY
		.on 'end', ->
			gutil.log 'scripts: TypeScript compilation complete'
			deferred.resolve()

	deferred.promise

processViews = ->
	deferred = q.defer()

	return deferred.resolve() if isProd

	gulp
		.src VIEWS, cwd: TEMP_DIRECTORY
		.pipe gulp.dest DIST_DIRECTORY
		.on 'end', ->
			gutil.log 'views: processing complete'
			deferred.resolve()

	deferred.promise

gulp.task 'bower', ->
	deferred = q.defer()

	options =
		directory: BOWER_DIRECTORY

	components = []

	for component, value of BOWER_COMPONENTS
		for version, files of value
			components.push "#{component}##{version}"

	bower
		.commands
		.install components, {}, options
		.on 'error', onError
		.on 'end', (results) ->
			deferred.resolve results

	deferred.promise

gulp.task 'build', ['scripts', 'styles', 'views', 'fonts', 'spa']

gulp.task 'changelog', ->
	options =
		repository: pkg.repository.url
		version: pkg.version
		file: CHANGELOG_FILE
		log: gutil.log

	conventionalChangelog options, (err, log) ->
		fs.writeFile CHANGELOG_FILE, log

gulp.task 'clean', ['clean:working'], ->
	gulp
		.src BOWER_DIRECTORY
		.pipe clean()
		.on 'error', onError

gulp.task 'clean:working', ->
	gulp
		.src [COMPONENTS_DIRECTORY, TEMP_DIRECTORY, DIST_DIRECTORY, DOCS_DIRECTORY]
		.pipe clean()
		.on 'error', onError

gulp.task 'copy:temp', ['clean:working', 'normalizeComponents'], ->
	gulp
		.src [
			"#{SRC_DIRECTORY}**"
			"#{COMPONENTS_DIRECTORY}**"
		]
		.pipe gulp.dest TEMP_DIRECTORY

gulp.task 'default', if isProd then ['open'] else ['open', 'watch', 'build', 'test']

gulp.task 'e2e', ->
	e2eConfigFile       = path.join './', TEMP_DIRECTORY, 'e2e-config.coffee'
	phantomjsBinaryPath = if isWindows then './node_modules/.bin/phantomjs.cmd' else './node_modules/phantomjs/bin/phantomjs'

	# create temporary e2e-config file to avoid an additional config file
	# currently gulp-protractor requires one the existence of an e2e-config file
	do (e2eConfigFile) ->
		doesExist = fs.existsSync TEMP_DIRECTORY

		if !doesExist
			throw new Error 'The app must be currently running (gulp).'

		contents = 'exports.config = {}'

		fs.writeFileSync e2eConfigFile, contents

	options =
		configFile: e2eConfigFile
		args: [
			'--baseUrl', appUrl
			'--browser', 'phantomjs'
			'--capabilities.phantomjs.binary.path', phantomjsBinaryPath
		]

	gulp
		.src '**/*.spec.{coffee,js}', cwd: E2E_DIRECTORY
		.pipe protractor.protractor options
		.on 'error', onError

gulp.task 'e2e-driver', protractor.webdriver_standalone

gulp.task 'e2e-driver-update', protractor.webdriver_update

gulp.task 'fonts', ['copy:temp'], ->
	src = gulp.src '**/*.{eot,svg,ttf,woff}', cwd: TEMP_DIRECTORY

	return if isProd
		src
			.pipe flatten()
			.on 'error', onError
			.on 'end', ->
				gutil.log 'fonts: flattened'
			.pipe gulp.dest path.join DIST_DIRECTORY, FONTS_DIRECTORY

	src
		.pipe gulp.dest DIST_DIRECTORY

gulp.task 'karma', ->
	options =
		autoWatch: false
		background: true
		basePath: DIST_DIRECTORY
		browsers: [
			'PhantomJS'
		]
		colors: true
		files: SCRIPTS
		frameworks: [
			'jasmine'
		]
		keepalive: false
		logLevel: 'WARN'
		reporters: [
			'spec'
		]
		singleRun: true
		transports: [
			# 'websocket' # removed due to excessive socket connections
			'flashsocket'
			'xhr-polling'
			'jsonp-polling'
		]

	karma.server.start options

gulp.task 'minify:views', ['copy:temp'],->
	return true if not isProd

	options =
		empty: true
		quotes: true

	gulp
		.src VIEWS, cwd: TEMP_DIRECTORY
		.pipe minifyHtml options
		.on 'error', onError
		.pipe gulp.dest path.join TEMP_DIRECTORY

gulp.task 'normalizeComponents', ['bower', 'clean:working'], ->
	promises = []

	for componentType, files of bowerComponents
		promise = do (files, componentType) ->
			deferred = q.defer()

			gulp
				.src files, cwd: BOWER_DIRECTORY
				.pipe gulp.dest path.join COMPONENTS_DIRECTORY, VENDOR_DIRECTORY, componentType
				.on 'end', ->
					deferred.resolve()

			deferred.promise

		promises.push promise

	q.all promises

gulp.task 'open', ['serve'], ->
	options =
		url: appUrl

	gulp
		.src 'index.html', cwd: DIST_DIRECTORY
		.pipe open '', options
		.on 'error', onError

gulp.task 'reload', ['build'], ->
	gulp
		.src 'index.html', cwd: DIST_DIRECTORY
		.pipe connect.reload()
		.on 'error', onError

gulp.task 'scripts', ['copy:temp', 'templateCache'], ->
	processCoffeeScript()
		.then processTypeScript
		.then processJavaScript
		.then processSourceScripts

gulp.task 'serve', ['build'], ->
	connect.server
		livereload: !isProd
		port: PORT
		root: DIST_DIRECTORY

gulp.task 'spa', ['scripts', 'styles', 'views', 'fonts'], ->
	unixifyPath = (p) ->
		p.replace /\\/g, '/'

	includify = ->
		scripts = []
		styles  = []

		bufferContents = (file) ->
			return if file.isNull()

			ext = path.extname file.path
			p   = unixifyPath(path.join('/', path.relative(file.cwd, file.path)))

			return if ext is '.js'
				scripts.push p

			return if ext is '.css'
				styles.push p

		endStream = ->
			payload = {scripts, styles}
			@emit 'data', payload
			@emit 'end', payload

		es.through bufferContents, endStream

	getIncludes = ->
		deferred = q.defer()

		files = []
			.concat SCRIPTS
			.concat ['!**/*.spec.js']
			.concat STYLES

		gulp
			.src files, cwd: DIST_DIRECTORY
			.pipe includify()
			.on 'error', onError
			.on 'end', (data) ->
				deferred.resolve data

		deferred.promise

	processTemplate = (files) ->
		deferred = q.defer()

		options =
			empty: true
			quotes: true

		data =
			appName: APP_NAME
			scripts: files.scripts
			styles: files.styles

		source          = 'index.html'
		optimizedSource = if isProd then source else []
		optimizedFilter = filter optimizedSource

		gulp
			.src source, cwd: TEMP_DIRECTORY
			.pipe template data
			.on 'error', onError
			.on 'end', -> gutil.log 'spa: Templating complete'

			.pipe optimizedFilter
			.pipe minifyHtml options
			.on 'error', onError
			.on 'end', -> gutil.log 'spa: Minification complete' if isProd
			.pipe optimizedFilter.restore()

			.pipe gulp.dest DIST_DIRECTORY
			.on 'end', ->
				deferred.resolve()

		deferred.promise

	getIncludes()
		.then processTemplate

gulp.task 'styles', ['copy:temp'], ->
	processLess()
		.then processCss
		.then processSourceStyles

gulp.task 'templateCache', ['copy:temp'], ->
	return true if not isProd

	options =
		module: APP_NAME
		root: '/'

	gulp
		.src VIEWS, cwd: TEMP_DIRECTORY
		.pipe templateCache options
		.on 'error', onError
		.pipe gulp.dest path.join TEMP_DIRECTORY, SCRIPTS_MIN_DIRECTORY

gulp.task 'test', ['build'], ->
	return true if isProd

	# don't allow karma to block gulp
	command = if isWindows then '.\\node_modules\\.bin\\gulp.cmd' else 'gulp'
	spawn = childProcess.spawn command, ['karma'], {stdio: 'inherit'}

gulp.task 'views', ['copy:temp'], ->
	processJade()
		.then processMarkdown
		.then processViews
		.then processSourceViews

gulp.task 'watch', ['build'], ->
	return true if isProd

	gulp
		.watch "#{SRC_DIRECTORY}**/*.{coffee,css,html,jade,less,markdown,md,ts}", ['test', 'reload']