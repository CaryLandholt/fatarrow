{useBackendless, runSpecs} = require './options'

exports.unixifyPath = (p) ->
	p.replace /\\/g, '/'

exports.getScriptSources = (ext) ->
	["**/*#{ext}"]
		.concat if not useBackendless then ["!**/*.backend#{ext}"] else []
		.concat if not runSpecs       then ["!**/*.spec#{ext}"]    else []
