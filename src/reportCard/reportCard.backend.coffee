class ReportCardBackend extends Run
	constructor: ($httpBackend) ->
		$httpBackend.whenGET(/osrc.dfm.io/).passThrough()
		$httpBackend.whenGET(/.coffee/).passThrough()
		$httpBackend.whenGET(/.js/).passThrough()