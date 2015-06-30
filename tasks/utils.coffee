isWindows  = /^win/.test(process.platform)
notifier   = require 'node-notifier'
path       = require 'path'
{useBackendless, runSpecs} = require './options'

exports.getScriptSources = (ext) ->
	["**/*#{ext}"]
		.concat if not useBackendless then ["!**/*.backend#{ext}"] else []
		.concat if not runSpecs       then ["!**/*.spec#{ext}"]    else []

exports.notify = (message) ->
	notifier.notify
		title    : 'Fatarrow'
		message  : message
		icon     : path.join __dirname, 'assets/gulp-error.png'
		sound    : true

exports.unixifyPath = (p) ->
	p.replace /\\/g, '/'

exports.windowsify = (windowsCommand, nonWindowsCommand) ->
	if isWindows then windowsCommand else nonWindowsCommand
