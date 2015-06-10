yargs = require 'yargs'

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

isProd         = getSwitchOption 'prod'
useBackendless = not (isProd or getSwitchOption('backend'))
runSpecs       = !isProd and useBackendless and getSwitchOption 'specs'

module.exports =
	isProd         : isProd
	runSpecs       : runSpecs
	useBackendless : useBackendless
