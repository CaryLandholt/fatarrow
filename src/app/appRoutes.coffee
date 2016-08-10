angular = require 'angular'

class AppRoutes extends Config
	constructor: ($locationProvider, $routeProvider) ->
		$locationProvider.html5Mode on
		$routeProvider
		.otherwise
			redirectTo: '/'

module.exports = AppRoutes
