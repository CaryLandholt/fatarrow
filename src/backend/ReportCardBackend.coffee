class ReportCardBackend extends Run
	constructor: (@$log, @$httpBackend) ->
		@$httpBackend.whenGET(/osrc.dfm.io/).passThrough()