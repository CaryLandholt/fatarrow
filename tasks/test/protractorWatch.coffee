EXTENSIONS = require '../extensions'
{E2E_DIRECTORY} = require '../constants'

module.exports = (gulp, plugins) -> ->
	{onError} = require('../events') plugins

	extensions = []
		.concat EXTENSIONS.SCRIPTS.COMPILED
		.concat EXTENSIONS.SCRIPTS.UNCOMPILED

	sources = []
		.concat ("**/*#{extension}" for extension in extensions)

	watcher = gulp.watch sources, {cwd: E2E_DIRECTORY, maxListeners: 999}, ['protractor']
	watcher
		.on 'error', onError
