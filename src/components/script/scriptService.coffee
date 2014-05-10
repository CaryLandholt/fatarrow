class Script extends Service
	constructor: ($document, $location) ->
		url        = $location.$$absUrl
		prefix     = if url[-3..] is '/#/' then url[..-4] else url
		document   = $document[0]

		@getScripts = ->
			scriptTags = document.getElementsByTagName 'script'

			scripts = for scriptTag in scriptTags
				continue if not scriptTag.src

				trimmedScript = scriptTag.src.replace prefix, ''

				continue if trimmedScript[0] isnt '/'

				script = scriptTag.src.replace prefix, ''