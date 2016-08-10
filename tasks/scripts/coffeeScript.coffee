es                    = require 'event-stream'
getScriptSources      = require('../utils').getScriptSources
lintNotify            = require './reporters/lintNotify'
{COMPONENTS_DIRECTORY,
	TEMP_DIRECTORY,
	SRC_DIRECTORY}    = require '../constants'
templateOptions       = require '../templateOptions'
{ngClassifyOptions}   = require '../options'


module.exports = (gulp, plugins) -> ->
	{onError} = require('../events') plugins

	sources = getScriptSources '.coffee'
	srcs    = []

	srcs.push src =
		gulp
			.src sources, {cwd: SRC_DIRECTORY, nodir: true}
			.on 'error', onError

			.pipe plugins.template templateOptions
			.on 'error', onError

			.pipe plugins.ngclassify ngClassifyOptions
			.on 'error', onError

			.pipe plugins.coffeelint()
			.on 'error', onError

			.pipe lintNotify 'coffeelint'
			.on 'error', onError

			.pipe plugins.coffeelint.reporter 'default'
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

		.pipe plugins.coffee()
		.on 'error', onError

		.pipe gulp.dest TEMP_DIRECTORY
		.on 'error', onError
