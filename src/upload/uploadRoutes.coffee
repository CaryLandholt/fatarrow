class UploadRoutes extends Config
	constructor: ($routeProvider) ->
		$routeProvider
		.when '/upload',
			caption: 'Upload'
			controller: 'uploadController'
			controllerAs: 'controller'
			templateUrl: 'upload/upload.html'