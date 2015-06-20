yargs = require 'yargs'

yargs.options 'citest',
	default     : false
	description : 'Run tests and report exit codes'
	type        : 'boolean'

yargs.options 'injectcss',
	default     : false
	description : 'Injects CSS without reloading'
	type        : 'boolean'

yargs.options 'open',
	default     : true
	description : 'Open app from browser-sync'
	type        : 'boolean'

yargs.options 'specs',
	default     : true
	description : 'Run specs'
	type        : 'boolean'


getSwitchOption = (switches) ->
	isArray = Array.isArray switches
	keys    = if isArray then switches else [switches]
	key     = keys[0]

	for k in keys
		hasSwitch = !!yargs.argv[k]
		key       = k if hasSwitch

	set = yargs.argv[key]
	def = yargs.parse([])[key]

	value =
		if set is 'false' or set is false
			false
		else if set is 'true' or set is true
			true
		else
			def

citest            = getSwitchOption 'citest'
firstRun          = true
getBower          = getSwitchOption 'bower'
injectCss         = getSwitchOption 'injectcss'
isProd            = getSwitchOption 'prod'
open              = getSwitchOption 'open'
useBackendless    = not (isProd or getSwitchOption('backend'))
runSpecs          = !isProd and useBackendless and getSwitchOption 'specs'
ngClassifyOptions =
	appName: require('../config').APP_NAME

module.exports = {
	citest
	firstRun
	getBower
	injectCss
	isProd
	ngClassifyOptions
	open
	runSpecs
	useBackendless
}
