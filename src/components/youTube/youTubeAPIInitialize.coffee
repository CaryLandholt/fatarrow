angular = require 'angular'

class YouTubeInit extends Run
	constructor: (scriptService) ->
		scriptService.add '//www.youtube.com/iframe_api'

module.exports = YouTubeInit