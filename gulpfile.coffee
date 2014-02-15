# gulp scripts

bowerComponentsDirectory = './bower_components/'
componentsDirectory = './components/'
distDirectory = './dist/'
srcDirectory = './src/'
tempDirectory = './.temp/'

bower = require 'gulp-bower'
bowerFiles = require 'gulp-bower-files'
clean = require 'gulp-clean'
coffee = require 'gulp-coffee'
coffeelint = require 'gulp-coffeelint'
gulp = require 'gulp'
ngClassify = require 'gulp-ng-classify'

gulp.task 'bower', ->
	bower()

gulp.task 'clean', ->
	gulp
		.src [bowerComponentsDirectory, componentsDirectory, tempDirectory, distDirectory]
		.pipe clean()

gulp.task 'clean:working', ->
	gulp
		.src [componentsDirectory, tempDirectory, distDirectory]
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
		.src '**/*.coffee', cwd: srcDirectory
		.pipe coffeelint options
		.pipe coffeelint.reporter()

gulp.task 'components', ['bower', 'clean:working'], ->
	bowerFiles()
		.on 'data', (data) ->
			fileName = path.basename data.path
			ext = path.extname fileName
			subPath = ''

			switch ext
				when '.js' then subPath = '/scripts/libs/'
				when '.less', '.css' then subPath = '/styles/'
				when '.eot', '.svg', '.ttf', '.woff' then subPath = '/fonts/'

			p = path.join data.base, subPath, fileName
			data.path = p

			data
		.pipe gulp.dest componentsDirectory

gulp.task 'copy:temp', ['clean:working', 'components'], ->
	gulp
		.src ["#{srcDirectory}**", "#{componentsDirectory}**"]
		.pipe gulp.dest tempDirectory

gulp.task 'ngClassify', ['copy:temp'], ->
	gulp
		.src '**/*.coffee', cwd: tempDirectory
		.pipe ngClassify()
		.pipe gulp.dest tempDirectory

gulp.task 'scripts', ['coffee']



# gulp.task 'default', ['scripts', 'styles', 'views'], ->
# 	gulp
# 		.src "#{tempDirectory}**"
# 		.pipe gulp.dest distDirectory















changelog = require 'conventional-changelog'



es = require 'event-stream'
filter = require 'gulp-filter'
fs = require 'fs'

gutil = require 'gulp-util'
jade = require 'gulp-jade'
less = require 'gulp-less'
markdown = require 'gulp-markdown'
minifyHtml = require 'gulp-minify-html'

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

fonts = ['**/*.{eot,svg,ttf,woff}']
assets = [].concat(scripts).concat(styles).concat(fonts)




# inject = require 'gulp-inject'

# gulp.task 'inject', ->
# 	gulp
# 		.src assets, {cwd: tempDirectory, read: false}
# 		.pipe inject './index.html', ignorePath: path.resolve tempDirectory
# 		.pipe gulp.dest tempDirectory






bust = require 'gulp-buster'
rename = require 'gulp-rename'

gulp.task 'bust', ->
	bust.config
		length: 10

	gulp
		.src assets, cwd: tempDirectory
		.pipe bust 'busters.json'
		.pipe gulp.dest '.'

gulp.task 'bustit', ['bust'], ->
	busters = require './busters.json'

	gulp
		.src assets, cwd: tempDirectory
		.pipe rename (filePath) ->
			originalPath = path.join filePath.dirname, filePath.basename + filePath.extname
			hash = busters[originalPath]
			filePath.basename += ".#{hash}"

			filePath
		.pipe gulp.dest tempDirectory








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
		.pipe includify './.temp/index.html'
		.on 'data', (data) ->
			gulp
				.src './.temp/index.html'
				.pipe template data
				.pipe gulp.dest './.temp/'






gulp.task 'changelog', ->
	options =
		repository: pkg.repository.url
		version: pkg.version

	changelog options, (err, log) ->
		fs.writeFile './CHANGELOG.md', log






















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