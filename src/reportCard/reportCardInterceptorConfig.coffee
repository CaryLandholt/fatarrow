class ReportCardInterceptorConfig extends Config
	constructor: ($httpProvider) ->
		$httpProvider.interceptors.push 'ReportCardInterceptor'