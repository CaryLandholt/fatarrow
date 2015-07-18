{injectCss, runSpecs} = require './options'
EXTENSIONS = require './extensions'
{E2E_DIRECTORY, SRC_DIRECTORY} = require './constants'

module.exports = (gulp, plugins) -> ->
	{onError} = require('./events') plugins
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

	sources = []
		.concat ("**/*#{extension}" for extension in extensions)
		.concat '!**/*.spec.{js,coffee}'

	testSources = []
		.concat ("**/*.{spec.js,spec.coffee}" for extension in extensions)

	stylesSources = [].concat ("**/*#{extension}" for extension in stylesExtensions)

	watcher       = gulp.watch sources, {cwd: SRC_DIRECTORY, maxListeners: 999}, tasks
	e2eWatcher    = gulp.watch testSources, {cwd: E2E_DIRECTORY, maxListeners: 999}, ['protractor']
	karmaWatcher  = gulp.watch testSources, {cwd: SRC_DIRECTORY, maxListeners: 999}, ['unittest']
	stylesWatcher = gulp.watch stylesSources, {cwd: SRC_DIRECTORY, maxListeners: 999}, [].concat(if injectCss then ['build'] else ['reload'])
	#
	watcher
		.on 'change', (event) ->
			require('./options').firstRun = true if event.type is 'deleted'
		.on 'error', onError
