class Home extends Controller
	constructor: (scriptService) ->
		scripts = scriptService.getScripts()
		@scripts = []

		angular.forEach scripts, (script) =>
			@scripts.push script if script.indexOf('/vendor/') isnt 0