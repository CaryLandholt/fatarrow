del = require 'del'
{BOWER_FILE, COMPONENTS_DIRECTORY, DIST_DIRECTORY, PROTRACTOR_SCREENSHOTS, TEMP_DIRECTORY, TEST_RESULTS_DIRECTORY} = require '../constants'
{getBower, injectCss} = require '../options'

module.exports = (gulp, plugins) -> (cb) ->
	{onError} = require('../events') plugins
	sources = [PROTRACTOR_SCREENSHOTS, TEST_RESULTS_DIRECTORY]
		.concat if injectCss then [] else [DIST_DIRECTORY]
		.concat if require('../options').firstRun then [TEMP_DIRECTORY] else []

	del sources, (err) ->
		cb err
