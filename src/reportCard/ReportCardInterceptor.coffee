class ReportCardInterceptor extends Factory
	constructor: ->
		return {
			response: (response) ->
				url     = response.config.url
				isMatch = !!url.match(/osrc.dfm.io/)

				if isMatch
					gravatar               = response.data.gravatar
					response.data.gravatar = "https://secure.gravatar.com/avatar/#{gravatar}?s=220&d=https://a248.e.akamai.net/assets.github.com/images/gravatars/gravatar-user-420.png"

				response
		}