class ReadmeRoutes extends Config
	constructor: ($routeProvider) ->
		$routeProvider
		.when '/readme',
			caption: 'Readme'
			controller: 'readmeController'
			controllerAs: 'controller'
			templateUrl: 'readme/readme.html'