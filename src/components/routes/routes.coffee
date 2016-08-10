angular = require 'angular'

class Routes extends Directive
	constructor: (routesService) ->
		link = (scope, element, attrs) ->
			scope.routes = routesService.routes

		return {
			replace: true
			link
			restrict: 'E'
			templateUrl: 'components/routes/routes.html'
		}

module.exports = Routes
