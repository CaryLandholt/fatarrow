class Routes extends Directive
	constructor: (routesService) ->
		link = (scope, element, attrs) ->
			scope.routes = routesService.routes

		return {
			link
			replace: true
			restrict: 'E'
			templateUrl: 'components/routes/routes.html'
		}