class HomeRoutes extends Config
	constructor: ($routeProvider) ->
		$routeProvider
		.when '/',
			caption: 'Home'
			controller: 'homeController'
			controllerAs: 'controller'
			templateUrl: 'home/home.html'
