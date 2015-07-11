config   = require '../../config/locationDeploy.coffee'
{SRC_DIRECTORY,
	DIST_DIRECTORY}  = require '../constants'

module.exports = (gulp, plugins) -> ->
	{onError} = require('../events') plugins
	sources   = '**'
	gulp
		.src sources, {cwd: DIST_DIRECTORY, nodir: true}
		.on 'error', onError

		.pipe gulp.dest config.location
		.on 'error', onError
