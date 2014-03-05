class HomeRoutes extends Config
	constructor: ($routeProvider) ->
		$routeProvider
		.when '/',
			controller: 'homeController'
			templateUrl: '/home/home.html'