class ReportCard extends Controller
	constructor: (reportCardService) ->
		@getReportCard = (username) ->
			reportCardService.get(username).then (results) =>
				@reportCard = results