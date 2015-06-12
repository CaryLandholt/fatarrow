es                    = require 'event-stream'
getScriptSources      = require('../utils').getScriptSources
{COMPONENTS_DIRECTORY,
	TEMP_DIRECTORY,
	SRC_DIRECTORY}    = require '../constants'
templateOptions       = require '../templateOptions'
{ngClassifyOptions}   = require '../options'

module.exports = (gulp, plugins) -> ->
	{onError} = require('../events') plugins
	options =
		coffeeLint:
			arrow_spacing:
				level: 'error'
			indentation:
				value: 1
			max_line_length:
				level: 'ignore'
			no_tabs:
				level: 'ignore'
		sourceMaps:
			sourceRoot: './'

	sources = getScriptSources '.coffee'
	srcs    = []

	srcs.push src =
		gulp
			.src sources, {cwd: SRC_DIRECTORY, nodir: true}
			.on 'error', onError

			.pipe plugins.coffeelint options.coffeeLint
			.on 'error', onError

			.pipe plugins.template templateOptions
			.on 'error', onError

			.pipe plugins.ngclassify ngClassifyOptions
			.on 'error', onError

	srcs.push src =
		gulp
			.src sources, {cwd: COMPONENTS_DIRECTORY, nodir: true}
			.on 'error', onError

			.pipe gulp.dest TEMP_DIRECTORY
			.on 'error', onError

	es
		.merge.apply @, srcs
		.on 'error', onError

		.pipe plugins.newer TEMP_DIRECTORY
		.on 'error', onError

		.pipe gulp.dest TEMP_DIRECTORY
		.on 'error', onError

		.pipe plugins.sourcemaps.init()
		.on 'error', onError

		.pipe plugins.coffee()
		.on 'error', onError

		.pipe plugins.sourcemaps.write './', options.sourceMaps
		.on 'error', onError

		.pipe gulp.dest TEMP_DIRECTORY
		.on 'error', onError
