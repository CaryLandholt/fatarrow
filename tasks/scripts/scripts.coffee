browserify = require 'browserify'
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'
deglobalify = require 'deglobalify'

{DIST_DIRECTORY, TEMP_DIRECTORY, SCRIPTS_MIN_DIRECTORY, SCRIPTS_MIN_FILE, SRC_DIRECTORY} = require '../constants'
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

	# src =
	# 	gulp
	# 		.src sources, {cwd: TEMP_DIRECTORY, nodir: true}
	# 		.on 'error', onError

	# return if isProd
	# 	src
	# 		.pipe plugins.ngannotate()
	# 		.on 'error', onError

	# 		.pipe plugins.concat SCRIPTS_MIN_FILE
	# 		.on 'error', onError

	# 		.pipe plugins.uglify()
	# 		.on 'error', onError

	# 		.pipe plugins.rev()
	# 		.on 'error', onError

	# 		.on 'data', onRev
	# 		.on 'error', onError

	# 		.on 'data', onScript
	# 		.on 'error', onError

	# 		.pipe gulp.dest path.join DIST_DIRECTORY, SCRIPTS_MIN_DIRECTORY
	# 		.on 'error', onError
	b = browserify
			entries: path.join TEMP_DIRECTORY, 'index.js'
			debug: (not isProd)
			# defining transforms here will avoid crashing your stream
			transform: [deglobalify]

	# src
	b.bundle()
		.pipe(source('bundle.js'))
		.pipe(buffer())
		# .pipe(sourcemaps.init({loadMaps: true}))
		# Add transformation tasks to the pipeline here.
		# .pipe(uglify())
		# .on('error', gutil.log)
		# .pipe(sourcemaps.write('./'))
		.on 'data', onScript
		.on 'error', onError

		.pipe(gulp.dest(DIST_DIRECTORY))
		.on 'error', onError
