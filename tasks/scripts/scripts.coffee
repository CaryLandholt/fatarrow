{DIST_DIRECTORY, TEMP_DIRECTORY, SCRIPTS_MIN_DIRECTORY, SCRIPTS_MIN_FILE} = require '../constants'
{isProd, useBackendless, runSpecs} = require '../options'
path = require 'path'
{SCRIPTS} = require '../../config/scripts'

module.exports = (gulp, plugins) -> ->
	{onError, onRev, onScript} = require('../events') plugins
	sources = do (ext ='.js') ->
		SCRIPTS
			.concat if not (runSpecs or useBackendless) then ["!**/angular-mocks#{ext}"] else []
			.concat if not useBackendless               then ["!**/*.backend#{ext}"]     else []
			.concat if not runSpecs                     then ["!**/*.spec#{ext}"]        else []

	src =
		gulp
			.src sources, {cwd: TEMP_DIRECTORY, nodir: true}
			.on 'error', onError

	return if isProd
		src
			.pipe plugins.ngannotate()
			.on 'error', onError

			.pipe plugins.concat SCRIPTS_MIN_FILE
			.on 'error', onError

			.pipe plugins.uglify()
			.on 'error', onError

			.pipe plugins.rev()
			.on 'error', onError

			.on 'data', onRev
			.on 'error', onError

			.on 'data', onScript
			.on 'error', onError

			.pipe gulp.dest path.join DIST_DIRECTORY, SCRIPTS_MIN_DIRECTORY
			.on 'error', onError

	src
		.on 'data', onScript
		.on 'error', onError

		.pipe gulp.dest DIST_DIRECTORY
		.on 'error', onError
