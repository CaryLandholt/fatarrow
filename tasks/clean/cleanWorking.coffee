{BOWER_FILE, COMPONENTS_DIRECTORY, DIST_DIRECTORY, TEMP_DIRECTORY} = require '../constants'
{firstRun, getBower, injectCss} = require '../options'

module.exports = (gulp, plugins) -> ->
	{onError} = require('../events') plugins
	sources = [].concat(if injectCss then [] else [DIST_DIRECTORY]).concat(if firstRun then [TEMP_DIRECTORY] else []).concat(if getBower and firstRun then [COMPONENTS_DIRECTORY, BOWER_FILE] else [])

	gulp
		.src sources, {read: false}
		.on 'error', onError

		.pipe plugins.rimraf()
		.on 'error', onError
