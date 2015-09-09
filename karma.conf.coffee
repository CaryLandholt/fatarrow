{DIST_DIRECTORY, STATS_DIST_DIRECTORY} = require './tasks/constants'
{SCRIPTS} = require './config/scripts'
sources = [].concat SCRIPTS, '**/*.html'

module.exports = (config) ->
	config.set
		autoWatch: false
		basePath: 'dist'
		browsers: [
			'PhantomJS'
		]
		coverageReporter:
			type: 'html'
			dir : '../coverage/'
		exclude: ['stats/**']
		files: sources
		frameworks: [
			'jasmine'
		]
		keepalive: false
		logLevel: 'WARN'
		ngHtml2JsPreprocessor:
			stripPrefix: 'dist/'
		port: 9877
		preprocessors:
			'**/*.html': 'ng-html2js'
			'**/*.js'  : 'coverage'
		reporters: [
			'spec'
			'coverage',
			'junit'
		]
		singleRun: true
		transports: [
			'flashsocket'
			'xhr-polling'
			'jsonp-polling'
		]
		proxies:
			'/img': '/src/img'
		junitReporter:
			outputDir: '../testResults'
			suite: 'Karma Tests'
