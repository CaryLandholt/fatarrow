options = require 'yargs'
	.usage 'Run gulp with the following options.'
	.help '?'
	.option 'backend',
		alias       : 'b'
		default     : false
		description : 'Use your own backend'
		type        : 'boolean'
	.option 'bower',
		alias       : 'w'
		default     : true
		description : 'Force retrieve of Bower components'
		type        : 'boolean'
	.option 'help',
		alias       : 'h'
		default     : true
		description : 'Show help'
		type        : 'boolean'
	.option 'injectcss',
		alias       : 'i'
		default     : false
		description : 'Injects CSS without reloading'
		type        : 'boolean'
	.option 'open',
		alias       : 'o'
		default     : false
		description : 'Open app from browser-sync'
		type        : 'boolean'
	.option 'prod',
		alias       : 'p'
		default     : false
		description : 'Make a production build'
		type        : 'boolean'
	.option 'serve',
		alias       : 'v'
		default     : true
		description : 'Serve the app'
		type        : 'boolean'
	.option 'specs',
		alias       : 's'
		default     : true
		description : 'Run specs'
		type        : 'boolean'
	.option 'target',
		alias       : 't'
		description : 'Deployment target'
		type        : 'string'
	.option 'notify',
		alias       : 'n'
		default     : 'system'
		description : 'System or in-browser notifications. Defaults to "system". Use "browser" for browserSync notifications. Use "off" for no notification.'
		type        : 'string'
	.example 'gulp', 'Run with fake data with $httpBackend'
	.example 'gulp --backend', 'Run with real data from an api. See config.coffee for proxy configuraton.'
	.example 'gulp --prod --no-serve', 'Make a production build on a CI server without running the web server.'
	.example 'npm test', 'Run Karma and Protractor tests during a CI build.'
	.example 'gulp --injectcss', 'Use Browsersync to inject CSS http://www.browsersync.io/docs/gulp/#gulp-sass-css.'
	.example 'npm run deploy [-- --target location | s3]', 'Deploy to a target.'
	.epilog 'If you find an issue, feel free to file it at https://github.com/CaryLandholt/fatarrow/issues'
	.argv

getSwitchOption = (option) ->
	options[option]

firstRun          = true
getBower          = getSwitchOption 'bower'
showHelp          = !isProd and getSwitchOption 'help'
injectCss         = getSwitchOption 'injectcss'
isProd            = getSwitchOption 'prod'
open              = getSwitchOption 'open'
useBackendless    = not (isProd or getSwitchOption('backend'))
runServer         = getSwitchOption 'serve'
runSpecs          = !isProd and getSwitchOption 'specs'
runWatch          = !isProd and runServer
target            = getSwitchOption 'target'
notify            = getSwitchOption 'notify'
ngClassifyOptions =
	appName: require('../config/app').APP_NAME

module.exports = {
	firstRun
	getBower
	getSwitchOption
	showHelp
	injectCss
	isProd
	ngClassifyOptions
	notify
	open
	runSpecs
	runServer
	runWatch
	useBackendless
	target
}
