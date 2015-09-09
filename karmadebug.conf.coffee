{DIST_DIRECTORY, STATS_DIST_DIRECTORY} = require './tasks/constants'
{SCRIPTS} = require './config/scripts'
sources = [].concat SCRIPTS, '**/*.html'

module.exports = (config) ->
	config.set
		autoWatch: true
		basePath: 'dist'
		browsers: [
			'Chrome'
		]
		colors: true
		coverageReporter:
			type: 'html'
			dir : '../coverage/'
		exclude: ['stats/**', 'dist/vendor/**']
		files: sources
		frameworks: [
			'jasmine'
		]
		logLevel: 'WARN'
		ngHtml2JsPreprocessor:
			stripPrefix: 'dist/'
		preprocessors:
			'**/*.html': 'ng-html2js'
			'**/*.js'  : ['coverage', 'sourcemap']
		reporters: [
			'spec'
			'coverage',
		]
		singleRun: false
		transports: [
			'flashsocket'
			'xhr-polling'
			'jsonp-polling'
		]
		proxies:
			'/img': '/src/img'
