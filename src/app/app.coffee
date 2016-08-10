angular = require 'angular'
angularAnimate = require 'angular-animate'
angularRoute = require 'angular-route'
angularLoadingBar = require 'angular-loading-bar'

class App extends App
	constructor: ->
		dependencies = [
			'ngAnimate'
			'ngRoute'
			'angular-loading-bar'
		]

		if '<%= useBackendless %>' is 'true'
			require 'angular-mocks'
			dependencies.push('ngMockE2E')

		return dependencies

module.exports = App
