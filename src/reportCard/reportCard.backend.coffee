class ReportCardBackend extends Run
	constructor: ($httpBackend) ->
		$httpBackend.whenGET(/osrc.dfm.io/).passThrough()