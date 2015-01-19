class App extends App
	constructor: ->
		dependencies = [
			'ngAnimate'
			'ngRoute'
			'angularFileUpload'
			'angular-loading-bar'
		]

		dependencies.push('ngMockE2E') if '<%= useBackendless %>' is 'true'

		return dependencies