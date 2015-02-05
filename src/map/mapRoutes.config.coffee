class MapRoutes extends Config
	constructor: ($routeProvider) ->
		$routeProvider
		.when '/map',
			caption: 'Map'
			controller: 'mapController'
			controllerAs: 'controller'
			templateUrl: 'map/map.html'