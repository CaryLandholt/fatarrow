class AdminRoutes extends Config
	constructor: ($routeProvider) ->
		$routeProvider
		.when '/admin',
			controller: 'adminController'
			templateUrl: '/admin/admin.html'