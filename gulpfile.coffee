bower = require 'gulp-bower'
coffee = require 'gulp-coffee'
coffeelint = require 'gulp-coffeelint'
es = require 'event-stream'
filter = require 'gulp-filter'
gulp = require 'gulp'
gutil = require 'gulp-util'
jade = require 'gulp-jade'
less = require 'gulp-less'
markdown = require 'gulp-markdown'
minifyHtml = require 'gulp-minify-html'
rimraf = require 'gulp-rimraf'
template = require 'gulp-template'

gulp.task 'clean:bower', ->
	gulp.src('./bower_components/')
		.pipe(rimraf())

gulp.task 'bower', ->
	components = bower()

	components
		.pipe(filter (file) ->
			switch file.path
				when 'angular/angular.min.js'
					file.cwd = 'angular/'
					file.path = file.path.replace(file.cwd, '')
				when 'angular-animate/angular-animate.min.js'
					file.cwd = 'angular-animate/'
					file.path = file.path.replace(file.cwd, '')
				when 'angular-mocks/angular-mocks.js'
					file.cwd = 'angular-mocks/'
					file.path = file.path.replace(file.cwd, '')
				when 'angular-route/angular-route.min.js'
					file.cwd = 'angular-route/'
					file.path = file.path.replace(file.cwd, '')
				when 'html5shiv/dist/html5shiv-printshiv.js'
					file.cwd = 'html5shiv/dist/'
					file.path = file.path.replace(file.cwd, '')
				when 'json3/lib/json3.min.js'
					file.cwd = 'json3/lib/'
					file.path = file.path.replace(file.cwd, '')
				when 'requirejs/require.js'
					file.cwd = 'requirejs/'
					file.path = file.path.replace(file.cwd, '')
				else
					return false
		)
		.pipe(gulp.dest('./components/scripts/libs/'))

	components
		.pipe(filter (file) ->
			isLess = /bootstrap\/less\//.test(file.path)

			return if not isLess

			file.cwd = 'bootstrap/less/'
			file.path = file.path.replace(file.cwd, '')
		)
		.pipe(gulp.dest('./components/styles/'))

	components
		.pipe(filter (file) ->
			isLess = /bootstrap\/dist\/fonts\//.test(file.path)

			return if not isLess

			file.cwd = 'bootstrap/dist/fonts/'
			file.path = file.path.replace(file.cwd, '')
		)
		.pipe(gulp.dest('./components/fonts/'))


# gulp.task 'bower', ['clean:bower'], (cb) ->
# 	gulp.src('')
# 		.pipe(bower().on('end', ->
# 			cb(null, 'ok')
# 		))

gulp.task 'clean:temp', ->
	gulp.src('./.temp/')
		.pipe(rimraf())

gulp.task 'copy:temp', ['clean:temp'], ->
	gulp.src('./src/**')
		.pipe(gulp.dest('./.temp/'))

	gulp.src([
		'./bower_components/angular/angular.min.js'
		'./bower_components/angular-animate/angular-animate.min.js'
		'./bower_components/angular-mocks/angular-mocks.js'
		'./bower_components/angular-route/angular-route.min.js'
		'./bower_components/html5shiv/dist/html5shiv-printshiv.js'
		'./bower_components/json3/lib/json3.min.js'
		'./bower_components/requirejs/require.js'
	])
	.pipe(gulp.dest('./.temp/scripts/libs/'))

	gulp.src('./bower_components/bootstrap/less/**/*.less')
	.pipe(gulp.dest('./.temp/styles/'))

	gulp.src('./bower_components/bootstrap/dist/fonts/**/*.{eot,svg,ttf,woff}')
	.pipe(gulp.dest('./.temp/fonts/'))

gulp.task 'copy:dev', ->
	gulp.src('./.temp/**')
		.pipe(gulp.dest('./dist/'))

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

	gulp.src('./src/**/*.coffee')
		.pipe(coffeelint(options))
		.pipe(coffeelint.reporter())

gulp.task 'coffee', ['coffeelint'], ->
	gulp.src('./.temp/**/*.coffee')
		.pipe(coffee())
		.pipe(gulp.dest('./.temp/'))

gulp.task 'scripts', ->
	gulp.run('coffee')

gulp.task 'less', ->
	gulp.src('./.temp/styles/styles.less')
		.pipe(less())
		.pipe(gulp.dest('./.temp/styles/'))

gulp.task 'styles', ->
	gulp.run('less')

gulp.task 'template', ->
	data =
		scripts: '<script data-main="/scripts/main.js" src="/scripts/libs/require.js"></script>'
		styles: '<!--[if lte IE 8]> <script src="/scripts/libs/json3.js"></script> <script src="/scripts/libs/html5shiv-printshiv.js"></script> <![endif]--><link rel="stylesheet" href="/styles/styles.css" />'

	gulp.src('./.temp/**/*.{html,jade,md,markdown}')
		.pipe(template(data))
		.pipe(gulp.dest('./.temp/'))

gulp.task 'jade', ['template'], ->
	gulp.src('./.temp/**/*.jade')
		.pipe(jade(pretty: true))
		.pipe(gulp.dest('./.temp/'))

gulp.task 'markdown', ['template'], ->
	gulp.src('./.temp/**/*.{md,markdown}')
		.pipe(markdown())
		.pipe(gulp.dest('./.temp/'))

gulp.task 'views', ->
	gulp.run('jade', 'markdown')

gulp.task 'build', ['copy:temp'], ->
	gulp.run('scripts', 'styles', 'views')

gulp.task 'default', ['build'], ->
	gulp.run('copy:dev')

gulp.task 'init', ['bower'], ->
	gulp.run('default')






# gulp.task 'uglify', ['scripts'], ->
# 	gulp.src('./.temp/**/*.js')
# 		.pipe(uglify())
# 		.pipe(gulp.dest('./.temp/scripts/scripts.min.js'))











gulp.task 'minifyHtml', ['jade', 'markdown'], ->
	options =
		quotes: true

	gulp.src('./.temp/**/*.html')
		.pipe(minifyHtml(options))
		.pipe(gulp.dest('./.temp/'))








