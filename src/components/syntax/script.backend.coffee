class ScriptBackend extends Run
	constructor: ($httpBackend) ->
		$httpBackend.whenGET(/.coffee/).passThrough()
		$httpBackend.whenGET(/.js/).passThrough()