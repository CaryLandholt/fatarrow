class HomeRoutes extends Config
	constructor: ($routeProvider) ->
		$routeProvider
		.when '/',
			controller: 'homeController'
			controllerAs: 'controller'
			templateUrl: '/home/home.html'