es                    = require 'event-stream'
getScriptSources      = require('../utils').getScriptSources
lintNotify            = require './reporters/lintNotify'
{COMPONENTS_DIRECTORY,
	TEMP_DIRECTORY,
	SRC_DIRECTORY}    = require '../constants'
{jsHint} = require '../../config/jsHint'
{jscs} = require '../../config/jscs'

templateOptions       = require '../templateOptions'

module.exports = (gulp, plugins) -> ->
	{onError} = require('../events') plugins
	options = {
		jsHint
		jscs
	}

	sources = getScriptSources '.js'
	srcs    = []

	srcs.push src =
		gulp
			.src sources, {cwd: SRC_DIRECTORY, nodir: true}
			.on 'error', onError

			.pipe plugins.template templateOptions
			.on 'error', onError

			.pipe plugins.jscs options.jscs
			.on 'error', onError

			.pipe lintNotify 'jscs'
			.on 'error', onError

			.pipe plugins.jshint options.jsHint
			.on 'error', onError

			.pipe plugins.jshint.reporter 'default'
			.on 'error', onError

			.pipe lintNotify 'jshint'
			.on 'error', onError

	srcs.push src =
		gulp
			.src sources, {cwd: COMPONENTS_DIRECTORY, nodir: true}
			.on 'error', onError

	es
		.merge.apply @, srcs
		.on 'error', onError

		.pipe plugins.newer TEMP_DIRECTORY
		.on 'error', onError

		.pipe gulp.dest TEMP_DIRECTORY
		.on 'error', onError
