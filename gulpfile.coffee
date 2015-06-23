gulp                  = require 'gulp'
yargs                 = require 'yargs'

{APP_NAME, BOWER_COMPONENTS, LANGUAGES, PROXY_CONFIG, SCRIPTS, STYLES} = require './config'
{getBower, isProd, useBackendless, runServer, runSpecs, runWatch, showHelp} = require './tasks/options'

plugins = require './tasks/plugins'

taskRequire = (taskPath) ->
	require(taskPath) gulp, plugins

gulp.task 'help', require('./tasks/help') gulp

# Compile ESNext
gulp.task 'babel', ['prepare'], require('./tasks/scripts/babel') gulp, plugins

# Get components via Bower
gulp.task 'bower', ['clean:working'], require('./tasks/bower/bower') gulp, plugins

# build the app
gulp.task 'build', ['spa', 'fonts', 'images'], require('./tasks/build') gulp, plugins

# Generate CHANGELOG
gulp.task 'changelog', ['normalizeComponents', 'stats'], require('./tasks/changelog/changelog') gulp, plugins
# Clean all build directories
gulp.task 'clean', ['clean:working'], require('./tasks/clean/clean') gulp, plugins

# Clean working directories
gulp.task 'clean:working', require('./tasks/clean/cleanWorking') gulp, plugins

# Compile CoffeeScript
gulp.task 'coffeeScript', ['prepare'], taskRequire './tasks/scripts/coffeeScript'

# Compile CSS
gulp.task 'css', ['prepare'], require('./tasks/styles/css') gulp, plugins

# Default build
gulp.task 'default', [].concat(if runServer then ['server'] else ['build']).concat(if runWatch then ['watch'] else []).concat(if runSpecs then ['test'] else [])

# Execute E2E tests
gulp.task 'e2e', ['server'], require('./tasks/test/e2e') gulp, plugins

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
gulp.task 'karma', require('./tasks/test/karma') gulp, plugins

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
gulp.task 'reload', ['build'], require('./tasks/reload') gulp

# Compile Sass
gulp.task 'sass', ['prepare'], require('./tasks/styles/sass') gulp, plugins

# Process scripts
gulp.task 'scripts', ['javaScript'].concat(LANGUAGES.SCRIPTS).concat(if isProd then 'templateCache' else []), require('./tasks/scripts/scripts') gulp, plugins

# Start a web server without rebuilding
gulp.task 'serve', -> require('./tasks/server/server')()

# Start a web server
gulp.task 'server', ['build'], -> require('./tasks/server/server')()

# Process SPA
gulp.task 'spa', ['scripts', 'styles'].concat(if isProd then 'templateCache' else 'views'), require('./tasks/spa') gulp, plugins

# Execute stats
gulp.task 'stats', ['plato']

# Process styles
gulp.task 'styles', ['css'].concat(LANGUAGES.STYLES), require('./tasks/styles/styles') gulp, plugins

# Compile templateCache
gulp.task 'templateCache', ['html'].concat(LANGUAGES.VIEWS), require('./tasks/views/templateCache') gulp, plugins

# Execute unit tests
gulp.task 'test', ['e2e'], require('./tasks/test/test') gulp, plugins

# Compile TypeScript
gulp.task 'typeScript', ['prepare'], require('./tasks/scripts/typeScript') gulp, plugins

# Process views
gulp.task 'views', ['html'].concat(LANGUAGES.VIEWS), require('./tasks/views/views') gulp, plugins

# Watch and recompile on-the-fly
gulp.task 'watch', ['build'], require('./tasks/watch') gulp, plugins
