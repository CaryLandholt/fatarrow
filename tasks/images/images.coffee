{isProd} = require '../options'
{DIST_DIRECTORY, TEMP_DIRECTORY} = require '../constants'
EXTENSIONS = require '../extensions'

module.exports = (gulp, plugins) -> ->
	{onError} = require('../events') gulp, plugins
	sources = [].concat ("**/*#{extension}" for extension in EXTENSIONS.IMAGES.COMPILED)

	src =
		gulp
			.src sources, {cwd: TEMP_DIRECTORY, nodir: true}
			.on 'error', onError

	src
		.pipe gulp.dest DIST_DIRECTORY
		.on 'error', onError
