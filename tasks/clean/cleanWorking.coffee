del = require 'del'
{BOWER_FILE, COMPONENTS_DIRECTORY, DIST_DIRECTORY, PROTRACTOR_SCREENSHOTS, TEMP_DIRECTORY, TEST_RESULTS_DIRECTORY} = require '../constants'
{firstRun, getBower, injectCss} = require '../options'

module.exports = (gulp, plugins) -> (cb) ->
	{onError} = require('../events') plugins
	sources = [PROTRACTOR_SCREENSHOTS, TEST_RESULTS_DIRECTORY]
		.concat if injectCss then [] else [DIST_DIRECTORY]
		.concat if firstRun then [TEMP_DIRECTORY] else []
		.concat if getBower and firstRun then [COMPONENTS_DIRECTORY, BOWER_FILE] else []

	del sources, (err) ->
		cb err
