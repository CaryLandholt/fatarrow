class ReportCard extends Controller
	constructor: ($log, reportCardService) ->
		@getReportCard = (username) =>
			reportCardService.get(username).then (results) =>
				$log.debug results
				@reportCard = results