es = require 'event-stream'
{isProd} = require '../options'
{COMPONENTS_DIRECTORY, SRC_DIRECTORY, TEMP_DIRECTORY} = require '../constants'
EXTENSIONS = require '../extensions'

module.exports = (gulp, plugins) -> ->
	{onError} = require('../events') gulp, plugins
	sources = [].concat ("**/*#{extension}" for extension in EXTENSIONS.IMAGES.COMPILED)
	srcs    = []

	srcs.push src =
		gulp
			.src sources, {cwd: SRC_DIRECTORY, nodir: true}
			.on 'error', onError

	srcs.push src =
		gulp
			.src sources, {cwd: COMPONENTS_DIRECTORY, nodir: true}
			.on 'error', onError

	es
		.merge.apply @, srcs
		.on 'error', onError

		.pipe gulp.dest TEMP_DIRECTORY
		.on 'error', onError
