{useBackendless, runSpecs} = require './options'
isWindows      = /^win/.test(process.platform)

exports.unixifyPath = (p) ->
	p.replace /\\/g, '/'

exports.getScriptSources = (ext) ->
	["**/*#{ext}"]
		.concat if not useBackendless then ["!**/*.backend#{ext}"] else []
		.concat if not runSpecs       then ["!**/*.spec#{ext}"]    else []

exports.windowsify = (windowsCommand, nonWindowsCommand) ->
	if isWindows then windowsCommand else nonWindowsCommand
