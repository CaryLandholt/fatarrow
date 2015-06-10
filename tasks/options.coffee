yargs = require 'yargs'

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

module.exports =
	isProd:          getSwitchOption 'prod'
	useBackendless:  not (getSwitchOption('prod') or getSwitchOption('backend'))
