class ReportCardRoutes extends Config
	constructor: ($routeProvider) ->
		$routeProvider
		.when '/reportcard',
			controller: 'reportCardController'
			controllerAs: 'controller'
			templateUrl: '/reportCard/report-card.html'