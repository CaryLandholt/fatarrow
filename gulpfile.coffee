bower = require 'gulp-bower'
changelog = require 'conventional-changelog'
clean = require 'gulp-clean'
coffee = require 'gulp-coffee'
coffeelint = require 'gulp-coffeelint'
es = require 'event-stream'
filter = require 'gulp-filter'
fs = require 'fs'
gulp = require 'gulp'
gutil = require 'gulp-util'
jade = require 'gulp-jade'
less = require 'gulp-less'
markdown = require 'gulp-markdown'
minifyHtml = require 'gulp-minify-html'
ngClassify = require 'gulp-ng-classify'
path = require 'path'
pkg = require './package.json'
template = require 'gulp-template'




scripts = [
	'scripts/libs/angular.min.js'
	'scripts/libs/angular-mocks.js'
	'scripts/libs/angular-animate.min.js'
	'scripts/libs/angular-route.min.js'
	'!scripts/libs/html5shiv-printshiv.js'
	'!scripts/libs/json3.min.js'
	'**/*.js'
]

styles = [
	'styles/styles.css'
]



PluginError = gutil.PluginError

includify = (fileName, opt = {}) ->
	if !fileName
		throw new PluginError 'includify', 'Missing filename option'

	scriptsToInclude = []
	stylesToInclude = []

	bufferContents = (file) ->
		return if file.isNull()

		return if file.isStream()
			@emit 'error', new PluginError 'includify', 'Streaming not supported'

		ext = path.extname file.path
		p = path.resolve '/', path.relative file.cwd, file.path

		return if ext is '.js'
			scriptsToInclude.push p

		return if ext is '.css'
			stylesToInclude.push p

	endStream = ->
		return if scriptsToInclude.length is 0 or stylesToInclude.length is 0
			@emit 'end'

		@emit 'data', {scripts: scriptsToInclude, styles: stylesToInclude}
		@emit 'end'

	es.through bufferContents, endStream



gulp.task 'template', ['copy:temp', 'scripts', 'styles'], ->
	files = []
		.concat scripts
		.concat styles

	gulp
		.src files, cwd: './.temp/'
		.pipe includify('./.temp/index.html')
		.on 'data', (data) ->
			gulp
				.src './.temp/index.html'
				.pipe template data
				.pipe gulp.dest './.temp/'




gulp.task 'ngClassify', ['copy:temp'], ->
	gulp
		.src './.temp/**/*.coffee'
		.pipe ngClassify()
		.pipe gulp.dest './.temp/'

gulp.task 'changelog', ->
	options =
		repository: pkg.repository.url
		version: pkg.version

	changelog options, (err, log) ->
		fs.writeFile './CHANGELOG.md', log








gulp.task 'default', ['scripts', 'styles', 'views'], ->
	gulp
		.src './.temp/**'
		.pipe gulp.dest './dist/'

gulp.task 'clean', ->
	gulp
		.src ['./bower_components/', './components/', './.temp/', './dist/']
		.pipe clean()

gulp.task 'bower', ['clean'], ->
	trim = (file, prefix) ->
		file.cwd = prefix
		file.path = file.path.replace file.cwd, ''

	components = bower()

	components
		.pipe filter (file) ->
			switch file.path
				when 'angular/angular.min.js'
					trim file, 'angular/'
				when 'angular-animate/angular-animate.min.js'
					trim file, 'angular-animate/'
				when 'angular-mocks/angular-mocks.js'
					trim file, 'angular-mocks/'
				when 'angular-route/angular-route.min.js'
					trim file, 'angular-route/'
				when 'html5shiv/dist/html5shiv-printshiv.js'
					trim file, 'html5shiv/dist/'
				when 'json3/lib/json3.min.js'
					trim file, 'json3/lib/'
				else
					return false
		.pipe gulp.dest './components/scripts/libs/'

	components
		.pipe filter (file) ->
			isLess = /bootstrap\/less\//.test file.path

			return if not isLess

			trim file, 'bootstrap/less/'
		.pipe gulp.dest './components/styles/'

	components
		.pipe filter (file) ->
			isFont = /bootstrap\/dist\/fonts\//.test file.path

			return if not isFont

			trim file, 'bootstrap/dist/fonts/'
		.pipe gulp.dest './components/fonts/'

gulp.task 'copy:temp', ['clean', 'bower'], ->
	gulp
		.src ['./src/**', './components/**']
		.pipe gulp.dest './.temp/'

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
		.src './src/**/*.coffee'
		.pipe coffeelint options
		.pipe coffeelint.reporter()

gulp.task 'coffee', ['coffeelint', 'copy:temp', 'ngClassify'], ->
	options =
		sourceMap: true

	gulp
		.src './.temp/**/*.coffee'
		.pipe coffee options
		.pipe gulp.dest './.temp/'

gulp.task 'scripts', ['coffee']

gulp.task 'less', ['copy:temp'], ->
	gulp
		.src './.temp/styles/styles.less'
		.pipe less()
		.pipe gulp.dest './.temp/styles/'

gulp.task 'styles', ['less']



gulp.task 'jade', ['template'], ->
	options =
		pretty: true

	gulp
		.src './.temp/**/*.jade'
		.pipe jade options
		.pipe gulp.dest './.temp/'

gulp.task 'markdown', ['template'], ->
	gulp
		.src [
			'./.temp/**/*.md'
			'./.temp/**/*.markdown'
		]
		.pipe markdown()
		.pipe gulp.dest './.temp/'

gulp.task 'views', ['jade', 'markdown']

gulp.task 'minifyHtml', ['jade', 'markdown'], ->
	options =
		quotes: true

	gulp
		.src './.temp/**/*.html'
		.pipe minifyHtml options
		.pipe gulp.dest './.temp/'