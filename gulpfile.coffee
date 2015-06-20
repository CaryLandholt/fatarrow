{APP_NAME, BOWER_COMPONENTS, LANGUAGES, PROXY_CONFIG, SCRIPTS, STYLES} = require './config.coffee'

bower                 = require 'bower'
browserSync           = require 'browser-sync'
childProcess          = require 'child_process'
es                    = require 'event-stream'
fs                    = require 'fs'
gulp                  = require 'gulp'
karma                 = require 'karma'
path                  = require 'path'
pkg                   = require './package.json'
q                     = require 'q'
url                   = require 'url'
yargs                 = require 'yargs'

plugins = require './tasks/plugins'
{onError, onRev, onScript, onStyle} = require('./tasks/events') plugins

BOWER_DIRECTORY       = 'bower_components/'
COMPONENTS_DIRECTORY  = "#{BOWER_DIRECTORY}_/"
DIST_DIRECTORY        = 'dist/'
E2E_DIRECTORY         = 'e2e/'
SRC_DIRECTORY         = 'src/'
STATS_DIST_DIRECTORY  = 'stats/'
TEMP_DIRECTORY        = '.temp/'

{getSwitchOption} = require './tasks/options'

EXTENSIONS = require './tasks/extensions'

yargs
	.usage 'Run $0 with the following options.'

yargs.options 'backend',
	default     : false
	description : 'Use your own backend.  No backendless.'
	type        : 'boolean'

yargs.options 'bower',
	default     : true
	description : 'Force retrieve of Bower components'
	type        : 'boolean'

yargs.options 'help',
	default     : false
	description : 'Show help'
	type        : 'boolean'

yargs.options 'injectcss',
	default     : false
	description : 'Injects CSS without reloading'
	type        : 'boolean'

yargs.options 'prod',
	default     : false
	description : 'Execute with all optimzations.  App will open in the browser but no file watching.'
	type        : 'boolean'

yargs.options 'serve',
	default     : true
	description : 'Serve the app'
	type        : 'boolean'

yargs.options 'specs',
	default     : true
	description : 'Run specs'
	type        : 'boolean'

yargs.options 'stats',
	default     :  false
	description : 'Run statistics'
	type        : 'boolean'

{citest}       = require './tasks/options'
env            = plugins.util.env
firstRun       = true
getBower       = getSwitchOption 'bower'
injectCss	   = getSwitchOption 'injectcss'
isProd         = getSwitchOption 'prod'
isWindows      = /^win/.test(process.platform)
runStats       = !isProd and getSwitchOption 'stats'
useBackendless = not (isProd or getSwitchOption 'backend')
runServer      = getSwitchOption 'serve'
runSpecs       = !isProd and useBackendless and getSwitchOption 'specs'
runWatch       = !isProd and runServer
showHelp       = getSwitchOption 'help'

return if showHelp
	console.log '\n' + yargs.help()

getScriptSources = (ext) ->
	["**/*#{ext}"]
		.concat if not useBackendless then ["!**/*.backend#{ext}"] else []
		.concat if not runSpecs       then ["!**/*.spec#{ext}"]    else []

unixifyPath = (p) ->
	p.replace /\\/g, '/'

windowsify = (windowsCommand, nonWindowsCommand) ->
	if isWindows then windowsCommand else nonWindowsCommand

gulp.task 'babel', ['prepare'], require('./tasks/scripts/babel') gulp, plugins

# Get components via Bower
gulp.task 'bower', ['clean:working'], require('./tasks/bower/bower') gulp, plugins

# build the app
gulp.task 'build', ['spa', 'fonts', 'images'], ->
	extensions = []
		.concat EXTENSIONS.FONTS.COMPILED
		.concat EXTENSIONS.IMAGES.COMPILED
		.concat EXTENSIONS.SCRIPTS.COMPILED
		.concat EXTENSIONS.STYLES.COMPILED
		.concat EXTENSIONS.VIEWS.COMPILED

	getSources = ->
		['**/*.*'].concat ("!**/*#{extension}" for extension in extensions)

	srcs = []

	if not isProd
		srcs.push src =
			gulp
				.src '**', cwd: STATS_DIST_DIRECTORY
				.on 'error', onError

	if not isProd
		srcs.push src =
			gulp
				.src getSources(), {cwd: TEMP_DIRECTORY, nodir: true}
				.on 'error', onError

	extensions = extensions
		.concat EXTENSIONS.SCRIPTS.UNCOMPILED
		.concat EXTENSIONS.STYLES.UNCOMPILED
		.concat EXTENSIONS.VIEWS.UNCOMPILED

	sources = getSources()

	srcs.push src =
		gulp
			.src sources, {cwd: SRC_DIRECTORY, nodir: true}
			.on 'error', onError

	srcs.push src =
		gulp
			.src sources, {cwd: COMPONENTS_DIRECTORY, nodir: true}
			.on 'error', onError

	es
		.merge.apply @, srcs
		.on 'error', onError

		.pipe gulp.dest DIST_DIRECTORY
		.on 'error', onError

# Generate CHANGELOG
gulp.task 'changelog', ['normalizeComponents', 'stats'], require('./tasks/changelog/changelog') gulp, plugins
# Clean all build directories
gulp.task 'clean', ['clean:working'], require('./tasks/clean/clean') gulp, plugins

# Clean working directories
gulp.task 'clean:working', require('./tasks/clean/cleanWorking') gulp, plugins

# Compile CoffeeScript
gulp.task 'coffeeScript', ['prepare'], require('./tasks/scripts/coffeeScript') gulp, plugins

# Compile CSS
gulp.task 'css', ['prepare'], require('./tasks/styles/css') gulp, plugins

# Default build
gulp.task 'default', [].concat(if runServer then ['server'] else ['build']).concat(if runWatch then ['watch'] else []).concat(if runSpecs then ['test'] else [])

# Execute E2E tests
gulp.task 'e2e', ['server'], ->
	e2eConfigFile       = './protractor.config.coffee'
	sources             = '**/*.spec.{coffee,js}'

	options =
		protractor:
			configFile: e2eConfigFile

	str = gulp
		.src sources, {cwd: E2E_DIRECTORY, read: false}
		.on 'error', onError

		.pipe plugins.protractor.protractor options.protractor

	if citest
		str.on 'error', ->
			process.exit 1
		str.on 'end', ->
	else
		str.on 'error', onError

	str

# Update E2E driver
gulp.task 'e2e-driver-update', plugins.protractor.webdriver_update

# Process fonts
gulp.task 'fonts', ['fontTypes'], require('./tasks/fonts/fonts') gulp, plugins

# Compile fontTypes
gulp.task 'fontTypes', ['prepare'], require('./tasks/fonts/fontTypes') gulp, plugins

# Compile Haml
gulp.task 'haml', ['prepare'], require('./tasks/views/haml') gulp, plugins

# Compile html
gulp.task 'html', ['prepare'], require('./tasks/views/html') gulp, plugins

# Process images
gulp.task 'images', ['imageTypes'], require('./tasks/images/images') gulp, plugins

# Compile imageTypes
gulp.task 'imageTypes', ['prepare'], require('./tasks/images/imageTypes') gulp, plugins

# Compile Jade
gulp.task 'jade', ['prepare'], require('./tasks/views/jade') gulp, plugins

# Compile JavaScript
gulp.task 'javaScript', ['prepare'], require('./tasks/scripts/javaScript') gulp, plugins
# Execute karma unit tests
gulp.task 'karma', ->
	sources = [].concat SCRIPTS, '**/*.html'

	options =
		autoWatch: false
		background: true
		basePath: DIST_DIRECTORY
		browsers: [
			'PhantomJS'
		]
		colors: true
		exclude: ["#{STATS_DIST_DIRECTORY}**"]
		files: sources
		frameworks: [
			'jasmine'
		]
		keepalive: false
		logLevel: 'WARN'
		ngHtml2JsPreprocessor:
			stripPrefix: 'dist/'
		preprocessors:
			'**/*.html': 'ng-html2js'
		reporters: [
			'spec'
		]
		singleRun: true
		transports: [
			'flashsocket'
			'xhr-polling'
			'jsonp-polling'
		]

	karma.server.start options

# Compile Less
gulp.task 'less', ['prepare'], require('./tasks/styles/less') gulp, plugins

# Compile LiveScript
gulp.task 'liveScript', ['prepare'], require('./tasks/scripts/liveScript') gulp, plugins

# Compile Markdown
gulp.task 'markdown', ['prepare'], require('./tasks/views/markdown') gulp, plugins

# Normalize Bower components
gulp.task 'normalizeComponents', ['bower'], require('./tasks/bower/normalizeComponents') gulp, plugins

# Execute Plato complexity analysis
gulp.task 'plato', ['clean:working'], require('./tasks/plato/plato') gulp, plugins

# Prepare for compilation
gulp.task 'prepare', ['clean:working'].concat(if getBower then ['normalizeComponents'] else [])

# Reload the app in the default browser
gulp.task 'reload', ['build'], ->
	browserSync.reload()
	firstRun = false;

# Compile Sass
gulp.task 'sass', ['prepare'], require('./tasks/styles/sass') gulp, plugins
# Process scripts
gulp.task 'scripts', ['javaScript'].concat(LANGUAGES.SCRIPTS).concat(if isProd then 'templateCache' else []), require('./tasks/scripts/scripts') gulp, plugins

# Start a web server without rebuilding
gulp.task 'serve', ['build'], ->
	require('./tasks/server/server')()

# Start a web server
gulp.task 'server', ['build'], ->
	require('./tasks/server/server')()

# Process SPA
gulp.task 'spa', ['scripts', 'styles'].concat(if isProd then 'templateCache' else 'views'), require('./tasks/spa') gulp, plugins

# Execute stats
gulp.task 'stats', ['plato']

# Process styles
gulp.task 'styles', ['css'].concat(LANGUAGES.STYLES), require('./tasks/styles/styles') gulp, plugins

# Compile templateCache
gulp.task 'templateCache', ['html'].concat(LANGUAGES.VIEWS), require('./tasks/views/templateCache') gulp, plugins

# Execute unit tests

gulp.task 'test', ['e2e'], ->
	# launch karma in a new process to avoid blocking gulp
	command = windowsify '.\\node_modules\\.bin\\gulp.cmd', 'gulp'

	# get args from parent process to pass on to child process
	args  = ("--#{key}=#{value}" for own key, value of yargs.argv when key isnt '_' and key isnt '$0')
	args  = ['karma'].concat args
	karmaSpawn = childProcess.spawn command, args, {stdio: 'inherit'}

	if citest
		karmaSpawn.on 'exit', (code) ->
			process.exit code if code
			browserSync.exit()

# Compile TypeScript
gulp.task 'typeScript', ['prepare'], require('./tasks/scripts/typeScript') gulp, plugins

# Process views
gulp.task 'views', ['html'].concat(LANGUAGES.VIEWS), require('./tasks/views/views') gulp, plugins

# Watch and recompile on-the-fly
gulp.task 'watch', ['build'], ->
	tasks = ['reload'].concat if runSpecs then ['test'] else []

	extensions = []
		.concat EXTENSIONS.FONTS.COMPILED
		.concat EXTENSIONS.IMAGES.COMPILED
		.concat EXTENSIONS.SCRIPTS.COMPILED
		.concat EXTENSIONS.SCRIPTS.UNCOMPILED
		.concat EXTENSIONS.VIEWS.COMPILED
		.concat EXTENSIONS.VIEWS.UNCOMPILED

	stylesExtensions = []
		.concat EXTENSIONS.STYLES.COMPILED
		.concat EXTENSIONS.STYLES.UNCOMPILED

	sources = [].concat ("**/*#{extension}" for extension in extensions)
	stylesSources = [].concat ("**/*#{extension}" for extension in stylesExtensions)

	watcher = gulp.watch sources, {cwd: SRC_DIRECTORY, maxListeners: 999}, tasks
	watcher = gulp.watch sources, {cwd: E2E_DIRECTORY, maxListeners: 999}, ['test']
	stylesWater = gulp.watch stylesSources, {cwd: SRC_DIRECTORY, maxListeners: 999}, [].concat(if injectCss then ['build'] else ['reload'])

	watcher
		.on 'change', (event) ->
			firstRun = true if event.type is 'deleted'
		.on 'error', onError
