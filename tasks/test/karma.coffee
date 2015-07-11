karma     = require 'karma'
notify    = require('../utils').notify
{SCRIPTS} = require '../../config/scripts'
{DIST_DIRECTORY, STATS_DIST_DIRECTORY} = require '../constants'
{citest} = require '../options'

module.exports = (gulp, plugins) -> ->
	sources = [].concat SCRIPTS, '**/*.html'

	options =
		autoWatch: false
		background: true
		basePath: DIST_DIRECTORY
		browsers: [
			'PhantomJS'
		]
		colors: true
		coverageReporter:
			type: 'html'
			dir : '../coverage/'
		exclude: ["#{STATS_DIST_DIRECTORY}**"]
		files: sources
		frameworks: [
			'jasmine'
		]
		keepalive: false
		logLevel: 'WARN'
		ngHtml2JsPreprocessor:
			stripPrefix: 'dist/'
		preprocessors:
			'**/*.html': 'ng-html2js'
			'**/*.js'  : 'coverage'
		reporters: [
			'spec'
			'coverage'
		]
		singleRun: true
		transports: [
			'flashsocket'
			'xhr-polling'
			'jsonp-polling'
		]
		proxies:
			'/img': '/src/img'

	options.reporters.push 'junit'
	options.junitReporter =
		outputFile: '../testResults/karma-results.xml'
		suite: 'Karma Tests'

	karma.server.start options, (code) ->
		return if citest
		if code > 0
			notify 'Karma tests failed', false
		else
			notify 'Karma tests passed', true
