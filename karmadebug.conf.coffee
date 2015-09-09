{DIST_DIRECTORY, STATS_DIST_DIRECTORY} = require './tasks/constants'
{SCRIPTS} = require './config/scripts'
sources = [].concat SCRIPTS, '**/*.html'

module.exports = (config) ->
	config.set
		basePath: 'dist'
		browsers: [
			'Chrome'
		]
		exclude: ['stats/**']
		files: sources
		frameworks: [
			'jasmine'
		]
		logLevel: 'WARN'
		ngHtml2JsPreprocessor:
			stripPrefix: 'dist/'
		preprocessors:
			'**/*.html': 'ng-html2js'
			'**/*.js'  : ['sourcemap']
		reporters: [
			'spec'
		]
		proxies:
			'/img': '/src/img'
