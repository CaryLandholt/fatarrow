templateOptions = require './templateOptions'
{DIST_DIRECTORY, SRC_DIRECTORY} = require './constants'
{isProd} = require './options'

module.exports = (gulp, plugins) -> ->
	{onError} = require('./events') gulp, plugins
	options =
		minifyHtml:
			conditionals: true
			empty: true
			quotes: true
		template: JSON.parse JSON.stringify templateOptions

	# clear scripts and styles for reload
	templateOptions.scripts = []
	templateOptions.styles  = []

	sources = 'index.html'

	src =
		gulp
			.src sources, {cwd: SRC_DIRECTORY, nodir: true}
			.on 'error', onError

			.pipe plugins.template options.template
			.on 'error', onError

	return if isProd
		src
			.pipe plugins.minifyHtml options.minifyHtml
			.on 'error', onError

			.pipe gulp.dest DIST_DIRECTORY
			.on 'error', onError

	src
		.pipe gulp.dest DIST_DIRECTORY
		.on 'error', onError
