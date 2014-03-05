class Routes extends Config
	constructor: ($routeProvider) ->
		$routeProvider
		.otherwise
			redirectTo: '/'