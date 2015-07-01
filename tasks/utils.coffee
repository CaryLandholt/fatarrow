isWindows  = /^win/.test(process.platform)
notifier   = require 'node-notifier'
path       = require 'path'
{useBackendless, runSpecs} = require './options'

exports.getScriptSources = (ext) ->
	["**/*#{ext}"]
		.concat if not useBackendless then ["!**/*.backend#{ext}"] else []
		.concat if not runSpecs       then ["!**/*.spec#{ext}"]    else []

exports.notify = (message, success = true) ->
	notifier.notify
		title    : 'Fatarrow'
		message  : message
		icon     : path.join __dirname, if success then 'assets/gulp.png' else 'assets/gulp-error.png'
		# this will pop up notifications in separate groups
		group    : 'fatarrow'

exports.unixifyPath = (p) ->
	p.replace /\\/g, '/'

exports.windowsify = (windowsCommand, nonWindowsCommand) ->
	if isWindows then windowsCommand else nonWindowsCommand
