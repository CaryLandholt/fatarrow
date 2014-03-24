class AppRoutes extends Config
	constructor: ($routeProvider) ->
		$routeProvider
		.otherwise
			redirectTo: '/'