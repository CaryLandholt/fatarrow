class Routes extends Service
	constructor: ($route) ->
		@routes = {}

		for k, v of $route.routes
			continue if k is 'null'
			continue if k is ''

			k = if k.substr(-1) is '/' and k.length > 1 then k.substr(0, k.length - 1) else k

			continue if not v.caption

			route      = @routes[k]
			@routes[k] = v.caption if route isnt -1