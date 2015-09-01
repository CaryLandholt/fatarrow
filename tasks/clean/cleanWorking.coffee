del = require 'del'
{BOWER_FILE,
	COMPONENTS_DIRECTORY,
	COVERAGE_DIRECTORY,
	DIST_DIRECTORY,
	PROTRACTOR_SCREENSHOTS,
	STATS_DIST_DIRECTORY,
	TEMP_DIRECTORY,
	TEST_RESULTS_DIRECTORY} = require '../constants'
{getBower, injectCss} = require '../options'

module.exports = (gulp, plugins) -> (cb) ->
	{onError} = require('../events') plugins
	sources = [
		COMPONENTS_DIRECTORY
		COVERAGE_DIRECTORY
		PROTRACTOR_SCREENSHOTS
		STATS_DIST_DIRECTORY
		TEST_RESULTS_DIRECTORY
	]
		.concat if injectCss then [] else [DIST_DIRECTORY]
		.concat if require('../options').firstRun then [TEMP_DIRECTORY] else []

	del sources, (err) ->
		cb err
