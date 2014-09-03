class ReportCard extends Service
	constructor: (@$http) ->

	get: (username) =>
		@$http.jsonp "http://osrc.dfm.io/#{username}.json?callback=JSON_CALLBACK"
		.then (results) ->
			results.data