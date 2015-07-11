{APP_NAME} = require '../../config/app'
{TEMP_DIRECTORY} = require '../constants'

module.exports = (gulp, plugins) -> ->
	{onError} = require('../events') plugins
	options =
		templateCache:
			module: APP_NAME

	sources = [
		'**/*.html'
		'!index.html'
	]

	gulp
		.src sources, {cwd: TEMP_DIRECTORY, nodir: true}
		.on 'error', onError

		.pipe plugins.templatecache options.templateCache
		.on 'error', onError

		.pipe gulp.dest TEMP_DIRECTORY
		.on 'error', onError
