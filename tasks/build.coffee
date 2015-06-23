es = require 'event-stream'
EXTENSIONS = require './extensions'
{isProd} = require './options'
{COMPONENTS_DIRECTORY, DIST_DIRECTORY, SRC_DIRECTORY, STATS_DIST_DIRECTORY, TEMP_DIRECTORY} = require './constants'

module.exports = (gulp, plugins) -> ->
	{onError} = require('./events') plugins
	debug = plugins.debug
	extensions = []
		.concat EXTENSIONS.FONTS.COMPILED
		.concat EXTENSIONS.IMAGES.COMPILED
		.concat EXTENSIONS.SCRIPTS.COMPILED
		.concat EXTENSIONS.STYLES.COMPILED
		.concat EXTENSIONS.VIEWS.COMPILED

	getSources = ->
		['**/*.*'].concat ("!**/*#{extension}" for extension in extensions)

	srcs = []

	if not isProd
		srcs.push src =
			gulp
				.src getSources(), {cwd: TEMP_DIRECTORY, nodir: true}
				.on 'error', onError

	extensions = extensions
		.concat EXTENSIONS.SCRIPTS.UNCOMPILED
		.concat EXTENSIONS.STYLES.UNCOMPILED
		.concat EXTENSIONS.VIEWS.UNCOMPILED

	sources = getSources()

	srcs.push src =
		gulp
			.src sources, {cwd: SRC_DIRECTORY, nodir: true}
			.on 'error', onError

	srcs.push src =
		gulp
			.src sources, {cwd: COMPONENTS_DIRECTORY, nodir: true}
			.on 'error', onError

	es
		.merge srcs
		.on 'error', onError

		.pipe gulp.dest DIST_DIRECTORY
		.on 'error', onError
