{DIST_DIRECTORY, TEMP_DIRECTORY} = require '../constants'

module.exports = (gulp, plugins) -> ->
	{onError} = require('../events') plugins
	sources = [
		'**/*.html'
		'!index.html'
	]

	gulp
		.src sources, {cwd: TEMP_DIRECTORY, nodir: true}
		.on 'error', onError

		.pipe gulp.dest DIST_DIRECTORY
		.on 'error', onError
