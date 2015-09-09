getScriptSources = require('../utils').getScriptSources
{TEMP_DIRECTORY, SRC_DIRECTORY} = require '../constants'

module.exports = (gulp, plugins) -> ->
	{onError} = require('../events') plugins
	sources = getScriptSources '.es6'
	srcs    = []

	options =
		sourceMaps:
			sourceRoot: './'

	srcs.push src =
		gulp
			.src sources, {cwd: SRC_DIRECTORY, nodir: true}
			.on 'error', onError

			.pipe plugins.newer TEMP_DIRECTORY
			.on 'error', onError

			.pipe gulp.dest TEMP_DIRECTORY
			.on 'error', onError

			.pipe plugins.sourcemaps.init()
			.on 'error', onError

			.pipe plugins.babel options
			.on 'error', onError

			.pipe plugins.sourcemaps.write()
			.on 'error', onError

			.pipe gulp.dest TEMP_DIRECTORY
			.on 'error', onError
