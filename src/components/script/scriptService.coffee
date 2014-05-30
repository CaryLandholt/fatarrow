class Script extends Service
	constructor: ($document, $location) ->
		url    = $location.$$absUrl
		prefix = if url[-3..] is '/#/' then url[..-4] else url
		doc    = $document[0]

		@add = (url) ->
			tag            = doc.createElement 'script'
			tag.src        = url
			scriptTags     = doc.getElementsByTagName 'script'
			firstScriptTag = scriptTags[0]

			firstScriptTag.parentNode.insertBefore tag, firstScriptTag

		@get = ->
			scriptTags = doc.getElementsByTagName 'script'

			scripts = for scriptTag in scriptTags
				continue if not scriptTag.src

				trimmedScript = scriptTag.src.replace prefix, ''

				continue if trimmedScript[0] isnt '/'

				script = scriptTag.src.replace prefix, ''