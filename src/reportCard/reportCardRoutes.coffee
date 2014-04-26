class ReportCardRoutes extends Config
	constructor: ($routeProvider) ->
		$routeProvider
		.when '/reportcard',
			caption: 'Your Open Source Report Card'
			controller: 'reportCardController'
			controllerAs: 'controller'
			templateUrl: '/reportCard/report-card.html'