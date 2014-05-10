class ToExtension extends Filter
	constructor: ->
		return (script, ext) ->
			extensionStart = script.lastIndexOf '.'
			newScript      = script[..extensionStart - 1] + ext