{DIST_DIRECTORY, STATS_DIST_DIRECTORY} = require './tasks/constants'
{SCRIPTS} = require './config/scripts'
sources = []
	.concat SCRIPTS
	.concat '**/*.html'

module.exports = (config) ->
	config.set
		autoWatchBatchDelay: 1000
		basePath: 'dist'
		browsers: [
			'Chrome'
		]
		files: sources
		frameworks: ['jasmine']
		ngHtml2JsPreprocessor:
			stripPrefix: 'dist/'
		preprocessors:
			'**/*.html': 'ng-html2js'
		reporters: [
			'spec'
		]
		proxies:
			'/img': '/src/img'
