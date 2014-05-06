class Script extends Service
	constructor: ($document, $location) ->
		url        = $location.$$absUrl
		prefix     = if url[-3..] is '/#/' then url[..-4] else url
		document   = $document[0]
		scriptTags = document.getElementsByTagName 'script'

		@getScripts = ->
			scripts = []

			angular.forEach scriptTags, (scriptTag) ->
				return if not scriptTag.src

				trimmedScript = scriptTag.src.replace prefix, ''

				return if trimmedScript[0] isnt '/'

				script = scriptTag.src.replace prefix, ''

				scripts.push script

			scripts