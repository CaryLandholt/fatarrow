class HomeRoutes extends Config
	constructor: ($routeProvider) ->
		$routeProvider
		.when '/',
			controller: 'homeController'
			controllerAs: 'homeCtrl'
			templateUrl: '/home/home.html'