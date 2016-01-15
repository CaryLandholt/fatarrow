isWindows   = /^win/.test(process.platform)
browserSync = require 'browser-sync'
notifier    = require 'node-notifier'
path        = require 'path'
{notify, useBackendless, runSpecs} = require './options'

exports.getScriptSources = (ext) ->
	["**/*#{ext}"]
		.concat if not useBackendless then ["!**/*.backend#{ext}"] else []
		.concat if not runSpecs       then ["!**/*.spec#{ext}"]    else []

exports.notify = (message, success = true) ->
	if notify is 'browser'
		style = if success then 'style="color: green;"' else 'style="color: red;"'
		browserSync.notify '<span ' + style + '>' + message + '</span>', 3000
	else if notify is 'system'
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
