appName = 'app'

scripts = [
	'scripts/vendor/angular.min.js'
	'scripts/vendor/angular-mocks.js'
	'scripts/vendor/angular-animate.min.js'
	'scripts/vendor/angular-route.min.js'
	'scripts/app.js'
	'**/*.js'
]

styles = [
	'styles/styles.css'
]

bowerDirectory = './bower_components/'
changelog = './CHANGELOG.md'
componentsDirectory = "#{bowerDirectory}flattened_components/"
devPort = 8181
devServer = "http://localhost:#{devPort}"
distDirectory = './dist/'
docsDirectory = './docs/'
srcDirectory = './src/'
tempDirectory = './.temp/'

bower = require 'gulp-bower'
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
	bower()

gulp.task 'build', ['scripts', 'styles', 'views', 'spa'], ->
	gulp
		.src '**', cwd: tempDirectory
		.pipe gulp.dest distDirectory

gulp.task 'changelog', ->
	options =
		repository: pkg.repository.url
		version: pkg.version
		file: changelog
		log: gutil.log

	conventionalChangelog options, (err, log) ->
		fs.writeFile changelog, log

gulp.task 'clean', ['clean:working'], ->
	gulp
		.src bowerDirectory
		.pipe clean()

gulp.task 'clean:working', ->
	gulp
		.src [componentsDirectory, tempDirectory, distDirectory, docsDirectory]
		.pipe clean()

gulp.task 'coffee', ['coffeelint', 'ngClassify'], ->
	options =
		sourceMap: true

	gulp
		.src '**/*.coffee', cwd: tempDirectory
		.pipe coffee options
		.pipe gulp.dest tempDirectory

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
		.src ['**/*.coffee', '!scripts/app.coffee'], cwd: srcDirectory
		.pipe coffeelint options
		.pipe coffeelint.reporter()

gulp.task 'copy:temp', ['clean:working', 'flatten'], ->
	gulp
		.src ["#{srcDirectory}**", "#{componentsDirectory}**"]
		.pipe gulp.dest tempDirectory

gulp.task 'default', ['serve', 'watch', 'build']

gulp.task 'docs', ['yuidoc']

gulp.task 'flatten', ['flatten:fonts', 'flatten:scripts', 'flatten:styles']

gulp.task 'flatten:fonts', ['bower', 'clean:working'], ->
	gulp
		.src 'bootstrap/dist/fonts/**/*.{eot,svg,ttf,woff}', cwd: bowerDirectory
		.pipe flatten()
		.pipe gulp.dest "#{componentsDirectory}fonts/"

gulp.task 'flatten:scripts', ['bower', 'clean:working'], ->
	gulp
		.src [
			'angular/angular.min.js{,.map}'
			'angular-animate/angular-animate.min.js{,.map}'
			'angular-mocks/angular-mocks.js'
			'angular-route/angular-route.min.js{,.map}'
		], cwd: bowerDirectory
		.pipe flatten()
		.pipe gulp.dest "#{componentsDirectory}scripts/vendor/"

gulp.task 'flatten:styles', ['bower', 'clean:working'], ->
	gulp
		.src 'bootstrap/less/**/*.less', cwd: bowerDirectory
		.pipe flatten()
		.pipe gulp.dest "#{componentsDirectory}styles/"

gulp.task 'jade', ['copy:temp'], ->
	options =
		pretty: true

	gulp
		.src '**/*.jade', cwd: tempDirectory
		.pipe jade options
		.pipe gulp.dest tempDirectory

gulp.task 'less', ['copy:temp'], ->
	options =
		sourceMap: true
		sourceMapBasepath: path.resolve path.join tempDirectory, 'styles'

	gulp
		.src 'styles/styles.less', cwd: tempDirectory
		.pipe less options
		.pipe gulp.dest 'styles/', cwd: tempDirectory

gulp.task 'markdown', ['copy:temp'], ->
	gulp
		.src '**/*.{md,markdown}', cwd: tempDirectory
		.pipe markdown()
		.pipe gulp.dest tempDirectory

gulp.task 'ngClassify', ['copy:temp'], ->
	options =
		appName: appName or 'app'
		data:
			environment: 'dev'

	gulp
		.src '**/*.coffee', cwd: tempDirectory
		.pipe ngClassify options
		.pipe gulp.dest tempDirectory

gulp.task 'scripts', ['coffee']

gulp.task 'spa', ['scripts', 'styles', 'views'], ->
	unixifyPath = (p) ->
			regex = /\\/g
			p.replace regex, '/'

	includify = ->
		js = []
		css = []

		bufferContents = (file) ->
			return if file.isNull()

			ext = path.extname file.path
			p = unixifyPath(path.join('/', path.relative(file.cwd, file.path)))

			return if ext is '.js'
				js.push p

			return if ext is '.css'
				css.push p

		endStream = ->
			payload = {scripts: js, styles: css}
			@emit 'data', payload
			@emit 'end', payload

		es.through bufferContents, endStream

	getIncludes = ->
		deferred = Q.defer()

		files = []
			.concat scripts
			.concat styles

		gulp
			.src files, cwd: tempDirectory
			.pipe includify()
			.on 'end', (data) ->
				deferred.resolve data

		deferred.promise

	processTemplate = (files) ->
		deferred = Q.defer()

		data =
			appName: appName
			scripts: files.scripts
			styles: files.styles

		gulp
			.src 'index.html', cwd: tempDirectory
			.pipe template data
			.pipe gulp.dest tempDirectory
			.on 'end', ->
				deferred.resolve()

		deferred.promise

	getIncludes()
		.then processTemplate

gulp.task 'styles', ['less']

gulp.task 'views', ['jade', 'markdown']

gulp.task 'yuidoc', ->
	options =
		syntaxtype: 'coffee'

	gulp
		.src '**/*.coffee', cwd: srcDirectory
		.pipe yuidoc options
		.pipe gulp.dest docsDirectory

###
working on
###
gulp.task 'serve', ['build'], ->
	server = connect.server
		root: [distDirectory]
		port: devPort
		livereload: true

	server()

gulp.task 'watch', ['build'], ->
	gulp
		.watch "#{srcDirectory}**", ['dist']

gulp.task 'dist', ['build'], ->
	connect.reload()