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
pkg = require './package.json'
template = require 'gulp-template'

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
				when 'requirejs/require.js'
					trim file, 'requirejs/'
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

gulp.task 'template', ['copy:temp'], ->
	data =
		scripts: '<script data-main="/scripts/main.js" src="/scripts/libs/require.js"></script>'
		styles: '<!--[if lte IE 8]> <script src="/scripts/libs/json3.js"></script> <script src="/scripts/libs/html5shiv-printshiv.js"></script> <![endif]--><link rel="stylesheet" href="/styles/styles.css" />'

	gulp
		.src './.temp/**/*.{html,jade,md,markdown}'
		.pipe template data
		.pipe gulp.dest './.temp/'

gulp.task 'jade', ['template'], ->
	options =
		pretty: true

	gulp
		.src './.temp/**/*.jade'
		.pipe jade options
		.pipe gulp.dest './.temp/'

gulp.task 'markdown', ['template'], ->
	gulp
		.src './.temp/**/*.{md,markdown}'
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