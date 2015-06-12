{BOWER_DIRECTORY} = require '../constants'

module.exports = (gulp, plugins) -> ->
	{onError} = require('../events') plugins
	sources = BOWER_DIRECTORY

	gulp
		.src sources, {read: false}
		.on 'error', onError

		.pipe plugins.rimraf()
		.on 'error', onError
