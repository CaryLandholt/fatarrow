angular = require 'angular'

class ScriptBackend extends Run
	constructor: ($httpBackend) ->
		$httpBackend.whenGET(/.(coffee|js)/).passThrough()

module.exports = ScriptBackend