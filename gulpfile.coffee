### config begin ###
APP_NAME = 'app'

SCRIPTS = [
	'scripts/vendor/angular.min.js'
	'scripts/vendor/angular-mocks.js'
	'scripts/vendor/angular-animate.min.js'
	'scripts/vendor/angular-route.min.js'
	'app/App.js'
	'**/*.js'
]

STYLES = [
	'styles/styles.css'
]

BOWER_DIRECTORY = './bower_components/'
CHANGELOG = './CHANGELOG.md'
COMPONENTS_DIRECTORY = "#{BOWER_DIRECTORY}flattened_components/"
DEV_PORT = 8181
DIST_DIRECTORY = './dist/'
DOCS_DIRECTORY = './docs/'
SRC_DIRECTORY = './src/'
TEMP_DIRECTORY = './.temp/'
### config end ###

bower = require 'bower'
clean = require 'gulp-clean'
coffee = require 'gulp-coffee'
coffeelint = require 'gulp-coffeelint'
connect = require 'gulp-connect'
conventionalChangelog = require 'conventional-changelog'
es = require 'event-stream'
flatten = require 'gulp-flatten'
fs = require 'fs'
gulp = require 'gulp'
gutil = require 'gulp-util'
jade = require 'gulp-jade'
less = require 'gulp-less'
markdown = require 'gulp-markdown'
ngClassify = require 'gulp-ng-classify'
path = require 'path'
pkg = require './package.json'
Q = require 'q'
template = require 'gulp-template'
yuidoc = require 'gulp-yuidoc'

gulp.task 'bower', ->
	deferred = Q.defer()

	bower
		.commands
		.install()
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
		file: CHANGELOG
		log: gutil.log

	conventionalChangelog options, (err, log) ->
		fs.writeFile CHANGELOG, log

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
			'!app/App.coffee'
		], cwd: SRC_DIRECTORY
		.pipe coffeelint options
		.pipe coffeelint.reporter()

gulp.task 'copy:temp', ['clean:working', 'flatten'], ->
	gulp
		.src [
			"#{SRC_DIRECTORY}**"
			"#{COMPONENTS_DIRECTORY}**"
		]
		.pipe gulp.dest TEMP_DIRECTORY

gulp.task 'default', ['serve', 'watch', 'build']

gulp.task 'docs', ['yuidoc']

gulp.task 'flatten', ['flatten:fonts', 'flatten:scripts', 'flatten:styles']

gulp.task 'flatten:fonts', ['bower', 'clean:working'], ->
	gulp
		.src 'bootstrap/dist/fonts/**/*.{eot,svg,ttf,woff}', cwd: BOWER_DIRECTORY
		.pipe flatten()
		.pipe gulp.dest "#{COMPONENTS_DIRECTORY}fonts/"

gulp.task 'flatten:scripts', ['bower', 'clean:working'], ->
	gulp
		.src [
			'angular/angular.min.js{,.map}'
			'angular-animate/angular-animate.min.js{,.map}'
			'angular-mocks/angular-mocks.js'
			'angular-route/angular-route.min.js{,.map}'
		], cwd: BOWER_DIRECTORY
		.pipe flatten()
		.pipe gulp.dest "#{COMPONENTS_DIRECTORY}scripts/vendor/"

gulp.task 'flatten:styles', ['bower', 'clean:working'], ->
	gulp
		.src 'bootstrap/less/**/*.less', cwd: BOWER_DIRECTORY
		.pipe flatten()
		.pipe gulp.dest "#{COMPONENTS_DIRECTORY}styles/"

gulp.task 'jade', ['copy:temp'], ->
	options =
		pretty: true

	gulp
		.src '**/*.jade', cwd: TEMP_DIRECTORY
		.pipe jade options
		.pipe gulp.dest TEMP_DIRECTORY

gulp.task 'less', ['copy:temp'], ->
	options =
		sourceMap: true
		sourceMapBasepath: path.resolve path.join TEMP_DIRECTORY, 'styles'

	gulp
		.src 'styles/styles.less', cwd: TEMP_DIRECTORY
		.pipe less options
		.pipe gulp.dest 'styles/', cwd: TEMP_DIRECTORY

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

gulp.task 'reload', ['build'], ->
	gulp
		.src 'index.html', cwd: DIST_DIRECTORY
		.pipe connect.reload()

gulp.task 'scripts', ['coffee']

gulp.task 'serve', ['build'], ->
	server = connect.server
		livereload: true
		open: true
		port: DEV_PORT
		root: [DIST_DIRECTORY]

	server()

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
		deferred = Q.defer()

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
		deferred = Q.defer()

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

gulp.task 'views', ['jade', 'markdown']

gulp.task 'watch', ['build'], ->
	gulp
		.watch "#{SRC_DIRECTORY}**/*.{coffee,html,jade,less,markdown,md}", ['reload']

gulp.task 'yuidoc', ->
	options =
		syntaxtype: 'coffee'

	gulp
		.src '**/*.coffee', cwd: SRC_DIRECTORY
		.pipe yuidoc options
		.pipe gulp.dest DOCS_DIRECTORY