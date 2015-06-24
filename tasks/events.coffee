manifest                 = {}
{isProd, useBackendless} = require './options'
path                     = require 'path'
{SCRIPTS_MIN_DIRECTORY, STYLES_MIN_DIRECTORY}  = require './constants'
templateOptions          = require './templateOptions'
unixifyPath              = require('./utils').unixifyPath

module.exports = (plugins) ->
	onError = (e) ->
		return unless e
		isArray  = Array.isArray e
		err      = e.message or e
		errors   = if isArray then err else [err]
		messages = (error for error in errors)

		plugins.util.log plugins.util.colors.red message for message in messages
		@emit 'end' unless isProd

	onRev = (file) ->
		from           = path.relative file.revOrigBase, file.revOrigPath
		to             = path.relative file.revOrigBase, file.path
		manifest[from] = to

		file

	onScript = (file) ->
		filePath = path.relative file.base, file.path
		filePath = path.join SCRIPTS_MIN_DIRECTORY, filePath if file.revOrigBase
		filePath = unixifyPath filePath
		endsWith = '.spec.js'
		isSpec   = filePath.slice(-endsWith.length) is endsWith

		templateOptions.scripts.push filePath if not isSpec

		file

	onStyle = (file) ->
		filePath = path.relative file.base, file.path
		filePath = path.join STYLES_MIN_DIRECTORY, filePath if file.revOrigBase
		filePath = unixifyPath filePath

		templateOptions.styles.push filePath

		file

	{onError, onRev, onScript, onStyle}
