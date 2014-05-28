class YouTubeInit extends Run
	constructor: ($document) ->
		document = $document[0]
		tag = document.createElement 'script'
		tag.src = '//www.youtube.com/iframe_api'
		firstScriptTag = document.getElementsByTagName('script')[0]

		firstScriptTag.parentNode.insertBefore tag, firstScriptTag