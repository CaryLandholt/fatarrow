class Script extends Service
	constructor: ($document, $location) ->
		url    = $location.$$absUrl
		prefix = $location.$$protocol + '://' + $location.$$host + ':' + $location.$$port + '/'
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

				continue if trimmedScript[..$location.$$protocol.length - 1] is $location.$$protocol

				script = trimmedScript