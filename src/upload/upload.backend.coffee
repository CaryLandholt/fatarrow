class UploadBackend extends Run
	constructor: ($httpBackend) ->
		$httpBackend.whenPOST(/api\/upload/).passThrough()