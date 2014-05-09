class Home extends Controller
	constructor: (scriptService) ->
		scripts = scriptService.getScripts()
		@scripts = (script for script in scripts when script.indexOf('/vendor/') isnt 0)