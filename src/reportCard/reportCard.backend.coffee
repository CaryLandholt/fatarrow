class ReportCardBackend extends Run
	constructor: ($httpBackend) ->
		$httpBackend.whenJSONP(/osrc.dfm.io/).passThrough()