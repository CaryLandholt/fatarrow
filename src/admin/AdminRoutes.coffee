class AdminRoutes extends Config
	constructor: ($routeProvider) ->
		$routeProvider
		.when '/admin',
			controller: 'adminController'
			controllerAs: 'adminCtrl'
			templateUrl: '/admin/admin.html'