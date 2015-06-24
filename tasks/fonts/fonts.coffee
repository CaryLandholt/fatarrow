path = require 'path'
EXTENSIONS = require '../extensions'
{DIST_DIRECTORY, FONTS_DIRECTORY, TEMP_DIRECTORY} = require '../constants'
{isProd} = require '../options'

module.exports = (gulp, plugins) -> ->
	{onError} = require('../events') plugins
	sources = [].concat ("**/*#{extension}" for extension in EXTENSIONS.FONTS.COMPILED)

	src =
		gulp
			.src sources, {cwd: TEMP_DIRECTORY, nodir: true}
			.on 'error', onError

	return if isProd
		src
			.pipe plugins.flatten()
			.on 'error', onError

			.pipe gulp.dest path.join DIST_DIRECTORY, FONTS_DIRECTORY
			.on 'error', onError

	src
		.pipe gulp.dest DIST_DIRECTORY
		.on 'error', onError
