gulp               = require 'gulp'
yargs              = require 'yargs'

{SCRIPTS}          = require './config/scripts'
{STYLES}           = require './config/styles'
{BOWER_COMPONENTS} = require './config/bower'
{LANGUAGES}        = require './config/languages'
{getBower, isProd, useBackendless, runServer, runSpecs, runWatch, showHelp, target} = require './tasks/options'

plugins = require './tasks/plugins'

taskRequire = (taskPath) ->
	require(taskPath) gulp, plugins

gulp.task 'help', require('./tasks/help') gulp, plugins

# Compile ESNext
gulp.task 'babel', ['prepare'], taskRequire './tasks/scripts/babel'

# Get components via Bower
gulp.task 'bower', taskRequire './tasks/bower/bower'

# Build the app
gulp.task 'build', ['spa', 'fonts', 'images'], taskRequire './tasks/build'

# Generate CHANGELOG
gulp.task 'changelog', ['normalizeComponents', 'stats'], taskRequire './tasks/changelog/changelog'

# Clean all build directories
gulp.task 'clean:bower', taskRequire './tasks/clean/cleanBower'

# Clean working directories
gulp.task 'clean:working', taskRequire './tasks/clean/cleanWorking'

# Compile CoffeeScript
gulp.task 'coffeeScript', ['prepare'], taskRequire './tasks/scripts/coffeeScript'

# Compile CSS
gulp.task 'css', ['prepare'], taskRequire './tasks/styles/css'

# Default build
gulp.task 'default',
	[]
	.concat(if runServer then ['server'] else ['build'])
	.concat(if runWatch then ['watch'] else [])
	.concat(if runSpecs then ['test'] else [])
	.concat(if showHelp then ['help'] else [])

# Deploy
gulp.task 'locationDeploy', taskRequire './tasks/deploy/locationDeploy'
gulp.task 's3Deploy', taskRequire './tasks/deploy/s3Deploy'
gulp.task 'deploy', [].concat(if target is 's3' then ['s3Deploy'] else ['locationDeploy'])

# Execute E2E tests
gulp.task 'protractor', taskRequire './tasks/test/protractor'
gulp.task 'protractor:watch', ['protractor'], taskRequire './tasks/test/protractorWatch'
gulp.task 'protractor:ci', ['serve'], taskRequire './tasks/test/protractorCI'

# Update E2E driver
gulp.task 'e2e-driver-update', plugins.protractor.webdriver_update

# Process fonts
gulp.task 'fonts', ['fontTypes'], taskRequire './tasks/fonts/fonts'

# Compile fontTypes
gulp.task 'fontTypes', ['prepare'], taskRequire './tasks/fonts/fontTypes'

# Compile Haml
gulp.task 'haml', ['prepare'], taskRequire './tasks/views/haml'

# Compile html
gulp.task 'html', ['prepare'], taskRequire './tasks/views/html'

# Process images
gulp.task 'images', ['imageTypes'], taskRequire './tasks/images/images'

# Compile imageTypes
gulp.task 'imageTypes', ['prepare'], taskRequire './tasks/images/imageTypes'

# Compile Jade
gulp.task 'jade', ['prepare'], taskRequire './tasks/views/jade'

# Compile JavaScript
gulp.task 'javaScript', ['prepare'], taskRequire './tasks/scripts/javaScript'

# Execute karma unit tests
gulp.task 'karma', taskRequire './tasks/test/karma'

# Compile Less
gulp.task 'copy:less', ['prepare'], taskRequire './tasks/styles/copyLess'
gulp.task 'less', ['copy:less'], taskRequire './tasks/styles/less'

# Compile LiveScript
gulp.task 'liveScript', ['prepare'], taskRequire './tasks/scripts/liveScript'

# Compile Markdown
gulp.task 'markdown', ['prepare'], taskRequire './tasks/views/markdown'

# Normalize Bower components
gulp.task 'normalizeComponents', ['clean:working'], taskRequire './tasks/bower/normalizeComponents'

# Execute Plato complexity analysis
gulp.task 'plato', taskRequire './tasks/plato/plato'

# Prepare for compilation
gulp.task 'prepare', ['clean:working'].concat(if getBower then ['normalizeComponents'] else [])

# Reload the app in the default browser
gulp.task 'reload', ['build'], taskRequire './tasks/reload'

# Compile Sass
gulp.task 'sass', ['prepare'], taskRequire './tasks/styles/sass'

# Process scripts
gulp.task 'scripts', ['javaScript'].concat(LANGUAGES.SCRIPTS).concat(if isProd then 'templateCache' else []), taskRequire './tasks/scripts/scripts'

# Start a web server without rebuilding
gulp.task 'serve', ->  require('./tasks/server/server')()

# Start a web server
gulp.task 'server', ['build'], -> require('./tasks/server/server')()

# Process SPA
gulp.task 'spa', ['scripts', 'styles'].concat(if isProd then 'templateCache' else 'views'), taskRequire './tasks/spa'

# Execute stats
gulp.task 'stats', ['plato']

# Process styles
gulp.task 'styles', ['css'].concat(LANGUAGES.STYLES), taskRequire './tasks/styles/styles'

# Compile templateCache
gulp.task 'templateCache', ['html'].concat(LANGUAGES.VIEWS), taskRequire './tasks/views/templateCache'

# Execute unit tests
gulp.task 'test', [].concat(['build']), taskRequire './tasks/test/test'
gulp.task 'unittest', [].concat(['spa']), taskRequire './tasks/test/test'

# Compile TypeScript
gulp.task 'typeScript', ['prepare'], taskRequire './tasks/scripts/typeScript'

# Process views
gulp.task 'views', ['html'].concat(LANGUAGES.VIEWS), taskRequire './tasks/views/views'

# Watch and recompile on-the-fly
gulp.task 'watch', ['build'], taskRequire './tasks/watch'
