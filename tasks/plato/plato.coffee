es = require 'event-stream'
pkg = require '../../package.json'
{DIST_DIRECTORY, TEMP_DIRECTORY, SRC_DIRECTORY, STATS_DIRECTORY} = require '../constants'
{ngClassifyOptions}   = require '../options'
templateOptions = require '../templateOptions'

module.exports = (gulp, plugins) -> ->
	{onError} = require('../events') plugins
	options =
		plato:
			title: "#{pkg.name} v#{pkg.version}"

	srcs = []

	srcs.push src =
		gulp
			.src '**/*.coffee', {cwd: SRC_DIRECTORY, nodir: true}
			.on 'error', onError

			.pipe plugins.template templateOptions
			.on 'error', onError

			.pipe plugins.ngclassify ngClassifyOptions
			.on 'error', onError

			.pipe plugins.coffee()
			.on 'error', onError

	srcs.push src =
		gulp
			.src '**/*.js', {cwd: SRC_DIRECTORY, nodir: true}
			.on 'error', onError

			.pipe plugins.template templateOptions
			.on 'error', onError

	srcs.push src =
		gulp
			.src '**/*.ls', {cwd: SRC_DIRECTORY, nodir: true}
			.on 'error', onError

			.pipe plugins.template templateOptions
			.on 'error', onError

			.pipe plugins.livescript()
			.on 'error', onError

	srcs.push src =
		gulp
			.src '**/*.ts', {cwd: SRC_DIRECTORY, nodir: true}
			.on 'error', onError

			.pipe plugins.template templateOptions
			.on 'error', onError

			.pipe plugins.typescript()
			.on 'error', onError

	es
		.merge.apply @, srcs
		.on 'error', onError

		.pipe gulp.dest DIST_DIRECTORY
		.on 'error', onError

		.pipe plugins.plato STATS_DIRECTORY, options.plato
		.on 'error', onError
