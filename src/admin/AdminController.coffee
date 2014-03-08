class Admin extends Controller
	constructor: ($location) ->
		@select = (path) ->
			$location.path path