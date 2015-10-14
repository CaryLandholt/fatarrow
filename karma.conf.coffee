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
		files: sources
		frameworks: [
			'jasmine'
		]
		logLevel: 'WARN'
		ngHtml2JsPreprocessor:
			stripPrefix: 'dist/'
		port: 9877
		preprocessors:
			'**/*.html': 'ng-html2js'
			'!(vendor)/**/!(*spec).js': 'coverage'
		reporters: [
			'spec'
			'coverage'
		]
		specReporter:
			suppressSkipped: true
		singleRun: true
		proxies:
			'/img': '/src/img'
