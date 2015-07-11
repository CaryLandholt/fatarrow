getScriptSources = require('../utils').getScriptSources
{TEMP_DIRECTORY, SRC_DIRECTORY} = require '../constants'
{options} = require '../../config/babel'

module.exports = (gulp, plugins) -> ->
	{onError} = require('../events') plugins
	sources = getScriptSources '.es6'
	srcs    = []

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

			.pipe plugins.sourcemaps.write './', options.sourceMaps
			.on 'error', onError

			.pipe gulp.dest TEMP_DIRECTORY
			.on 'error', onError
