autoprefixer = require 'autoprefixer'
browserSync = require 'browser-sync'
{DIST_DIRECTORY, TEMP_DIRECTORY, STYLES_MIN_DIRECTORY, STYLES_MIN_FILE} = require '../constants'
{isProd, injectCss} = require '../options'
path = require 'path'
postcss = require 'gulp-postcss'
templateOptions = require '../templateOptions'
{STYLES} = require '../../config/styles'

module.exports = (gulp, plugins) -> ->
	{onError, onRev, onStyle} = require('../events') plugins
	options =
		minifyCss:
			keepSpecialComments: 0

	sources = STYLES

	src =
		gulp
			.src sources, {cwd: TEMP_DIRECTORY, nodir: true}
			.on 'error', onError

			# Now that we have all the preprocessor compilation done, we can perform
			# any processing that needs to happen to the raw CSS output.
			.pipe postcss([
				autoprefixer(browsers: ['last 2 versions'])
			])
			.on 'error', onError

	return if isProd
		src
			.pipe plugins.concat STYLES_MIN_FILE
			.on 'error', onError

			.pipe plugins.minifycss options.minifyCss
			.on 'error', onError

			.pipe plugins.rev()
			.on 'error', onError

			.on 'data', onRev
			.on 'error', onError

			.on 'data', onStyle
			.on 'error', onError

			.pipe gulp.dest path.join DIST_DIRECTORY, STYLES_MIN_DIRECTORY
			.on 'error', onError

	src
		.on 'data', onStyle
		.on 'error', onError

		.pipe gulp.dest DIST_DIRECTORY
		.on 'error', onError

		.pipe plugins.gulpif injectCss, browserSync.reload {stream: true}
