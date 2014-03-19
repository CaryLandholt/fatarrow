class ReportCard extends Controller
	constructor: ($log, @$location, reportCardService) ->
		@getReportCard = (username) =>
			reportCardService.get(username).then (results) =>
				$log.debug results
				@reportCard = results

	select: (path) ->
		@$location.path path