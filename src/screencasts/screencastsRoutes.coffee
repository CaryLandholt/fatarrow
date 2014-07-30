class ScreencastsRoutes extends Config
	constructor: ($routeProvider) ->
		$routeProvider
		.when '/screencasts',
			caption: 'Screencasts'
			controller: 'screencastsController'
			controllerAs: 'controller'
			templateUrl: 'screencasts/screencasts.html'