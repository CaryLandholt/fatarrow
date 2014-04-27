{APP_NAME, BOWER_COMPONENTS, SCRIPTS, STYLES} = require './config.coffee'

SCRIPTS.push '!**/*.spec.js'

BOWER_DIRECTORY       = '.components/'
CHANGELOG_FILE        = 'CHANGELOG.md'
COMPONENTS_DIRECTORY  = "#{BOWER_DIRECTORY}_/"
DEV_PORT              = 8181
DIST_DIRECTORY        = 'dist/'
DOCS_DIRECTORY        = 'docs/'
E2E_DIRECTORY         = 'e2e/'
SCRIPTS_MIN_FILE      = 'scripts.min.js'
SRC_DIRECTORY         = 'src/'
STYLES_MIN_FILE       = 'styles.min.css'
TEMP_DIRECTORY        = '.temp/'
VENDOR_DIRECTORY      = 'vendor/'

bower                 = require 'bower'
buster                = require 'gulp-buster'
childProcess          = require 'child_process'
clean                 = require 'gulp-clean'
coffee                = require 'gulp-coffee'
coffeelint            = require 'gulp-coffeelint'
concat                = require 'gulp-concat'
connect               = require 'gulp-connect'
conventionalChangelog = require 'conventional-changelog'
es                    = require 'event-stream'
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
rename                = require 'gulp-rename'
template              = require 'gulp-template'
templateCache         = require 'gulp-angular-templatecache'
typeScript            = require 'gulp-typescript'
uglify                = require 'gulp-uglify'

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

appUrl = "http://localhost:#{DEV_PORT}"

gulp.task 'bower', ->
	deferred = q.defer()
	components = []

	for component, value of BOWER_COMPONENTS
		for version, files of value
			components.push "#{component}##{version}"

	bower
		.commands
		.install components, {}, {directory: BOWER_DIRECTORY}
		.on 'end', (results) ->
			deferred.resolve results

	deferred.promise

gulp.task 'build', ['scripts', 'styles', 'views', 'spa'], ->
	gulp
		.src '**', cwd: TEMP_DIRECTORY
		.pipe gulp.dest DIST_DIRECTORY

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

gulp.task 'clean:working', ->
	gulp
		.src [COMPONENTS_DIRECTORY, TEMP_DIRECTORY, DIST_DIRECTORY, DOCS_DIRECTORY]
		.pipe clean()

gulp.task 'coffee', ['coffeelint', 'ngClassify'], ->
	options =
		sourceMap: true

	gulp
		.src '**/*.coffee', cwd: TEMP_DIRECTORY
		.pipe coffee options
		.pipe gulp.dest TEMP_DIRECTORY

gulp.task 'coffeelint', ->
	options =
		arrow_spacing:
			level: 'error'
		indentation:
			value: 1
		max_line_length:
			level: 'ignore'
		no_tabs:
			level: 'ignore'

	gulp
		.src [
			'**/*.coffee'
			'!app/app.coffee'
		], cwd: SRC_DIRECTORY
		.pipe coffeelint options
		.pipe coffeelint.reporter()

gulp.task 'copy:temp', ['clean:working', 'normalizeComponents'], ->
	gulp
		.src [
			"#{SRC_DIRECTORY}**"
			"#{COMPONENTS_DIRECTORY}**"
		]
		.pipe gulp.dest TEMP_DIRECTORY

gulp.task 'default', ['open', 'watch', 'build', 'test']

gulp.task 'docs', ['yuidoc']

gulp.task 'e2e', ->
	e2eConfigFile = path.join './', TEMP_DIRECTORY, 'e2e-config.coffee'

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
			'--baseUrl', appUrl,
			'--browser', 'phantomjs'
			'--capabilities.phantomjs.binary.path', './node_modules/phantomjs/bin/phantomjs'
		]

	gulp
		.src '**/*.spec.{coffee,js}', cwd: E2E_DIRECTORY
		.pipe protractor.protractor options

gulp.task 'e2e-driver', protractor.webdriver_standalone

gulp.task 'e2e-driver-update', protractor.webdriver_update

gulp.task 'jade', ['copy:temp'], ->
	options =
		pretty: true

	gulp
		.src '**/*.jade', cwd: TEMP_DIRECTORY
		.pipe jade options
		.pipe gulp.dest TEMP_DIRECTORY

gulp.task 'karma', ->
	scripts = SCRIPTS.slice 0

	# remove *.spec exclusion
	scripts.pop()

	options =
		autoWatch: false
		background: true
		basePath: DIST_DIRECTORY
		browsers: [
			'PhantomJS'
		]
		colors: true
		files: scripts
		frameworks: [
			'jasmine'
		]
		keepalive: false
		logLevel: 'WARN'
		reporters: [
			'dots'
		]
		singleRun: true
		transports: [
			# 'websocket' # removed due to excessive socket connections
			'flashsocket'
			'xhr-polling'
			'jsonp-polling'
		]

	karma.server.start options

gulp.task 'less', ['copy:temp'], ->
	options =
		sourceMap: true
		sourceMapBasepath: path.resolve TEMP_DIRECTORY

	gulp
		.src '**/*.less', cwd: TEMP_DIRECTORY
		.pipe less options
		.pipe gulp.dest TEMP_DIRECTORY

gulp.task 'markdown', ['copy:temp'], ->
	gulp
		.src '**/*.{md,markdown}', cwd: TEMP_DIRECTORY
		.pipe markdown()
		.pipe gulp.dest TEMP_DIRECTORY

gulp.task 'ngClassify', ['copy:temp'], ->
	options =
		appName: APP_NAME or 'app'
		data:
			environment: 'dev'

	gulp
		.src '**/*.coffee', cwd: TEMP_DIRECTORY
		.pipe ngClassify options
		.pipe gulp.dest TEMP_DIRECTORY

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

gulp.task 'reload', ['build'], ->
	gulp
		.src 'index.html', cwd: DIST_DIRECTORY
		.pipe connect.reload()

gulp.task 'scripts', ['coffee', 'typeScript']

gulp.task 'serve', ['build'], ->
	connect.server
		livereload: true
		port: DEV_PORT
		root: DIST_DIRECTORY

gulp.task 'spa', ['scripts', 'styles', 'views'], ->
	unixifyPath = (p) ->
			regex = /\\/g
			p.replace regex, '/'

	includify = ->
		scripts = []
		styles = []

		bufferContents = (file) ->
			return if file.isNull()

			ext = path.extname file.path
			p = unixifyPath(path.join('/', path.relative(file.cwd, file.path)))

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
			.concat STYLES

		gulp
			.src files, cwd: TEMP_DIRECTORY
			.pipe includify()
			.on 'end', (data) ->
				deferred.resolve data

		deferred.promise

	processTemplate = (files) ->
		deferred = q.defer()

		data =
			appName: APP_NAME
			scripts: files.scripts
			styles: files.styles

		gulp
			.src 'index.html', cwd: TEMP_DIRECTORY
			.pipe template data
			.pipe gulp.dest TEMP_DIRECTORY
			.on 'end', ->
				deferred.resolve()

		deferred.promise

	getIncludes()
		.then processTemplate

gulp.task 'styles', ['less']

gulp.task 'test', ['build'], ->
	# don't allow karma to block gulp
	isWindows = process.platform is 'win32'
	command = if isWindows then '.\\node_modules\\.bin\\gulp.cmd' else 'gulp'
	spawn = childProcess.spawn command, ['karma'], {stdio: 'inherit'}

gulp.task 'typeScript', ['copy:temp'], ->
	gulp
		.src '**/*.ts', cwd: TEMP_DIRECTORY
		.pipe typeScript()
		.pipe gulp.dest TEMP_DIRECTORY

gulp.task 'views', ['jade', 'markdown']

gulp.task 'watch', ['build'], ->
	gulp
		.watch "#{SRC_DIRECTORY}**/*.{coffee,css,html,jade,less,markdown,md,ts}", ['test', 'reload']









### prod ###
gulp.task 'minify', ['minify:scripts', 'minify:styles', 'minify:views', 'minify:spa']

gulp.task 'minify:scripts', ['templateCache'], ->
	gulp
		.src SCRIPTS, cwd: TEMP_DIRECTORY
		.pipe concat SCRIPTS_MIN_FILE
		.pipe uglify()
		.pipe gulp.dest TEMP_DIRECTORY

gulp.task 'minify:styles', ->
	options =
		keepSpecialComments: 0

	gulp
		.src STYLES, cwd: TEMP_DIRECTORY
		.pipe concat STYLES_MIN_FILE
		.pipe minifyCss options
		.pipe gulp.dest TEMP_DIRECTORY

gulp.task 'minify:spa', ->
	options =
		empty: true
		quotes: true

	gulp
		.src 'index.html', cwd: TEMP_DIRECTORY
		.pipe minifyHtml options
		.pipe gulp.dest TEMP_DIRECTORY

gulp.task 'minify:views', ->
	options =
		empty: true
		quotes: true

	gulp
		.src ['**/*.html', '!index.html'], cwd: TEMP_DIRECTORY
		.pipe minifyHtml options
		.pipe gulp.dest TEMP_DIRECTORY

gulp.task 'templateCache', ['minify:views'], ->
	options =
		module: APP_NAME
		root: '/'

	gulp
		.src ['**/*.html', '!index.html'], cwd: TEMP_DIRECTORY
		.pipe templateCache options
		.pipe gulp.dest "#{TEMP_DIRECTORY}scripts/"

gulp.task 'buster', ->
	options =
		length: 10

	buster.config options

	gulp
		.src '**/*.{css,js}', cwd: TEMP_DIRECTORY
		.pipe buster()
		.pipe gulp.dest TEMP_DIRECTORY

gulp.task 'hashify', ['buster'], ->
	busters = require "#{TEMP_DIRECTORY}busters.json"

	renamer = (file) ->
		originalFile = path.join file.dirname, file.basename + file.extname

		# gulp
		# 	.src originalFile, cwd: TEMP_DIRECTORY
		# 	.pipe clean()


		hash = busters[originalFile]
		file.basename += '.' + hash

		file

	gulp
		.src '**/*.{css,js}', cwd: TEMP_DIRECTORY
		.pipe rename renamer
		.pipe gulp.dest TEMP_DIRECTORY