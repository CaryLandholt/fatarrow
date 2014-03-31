class ReportCard extends Service
	constructor: (@$http) ->

	get: (username) =>
		@$http.get "http://osrc.dfm.io/#{username}.json"
		.then (results) ->
			results.data