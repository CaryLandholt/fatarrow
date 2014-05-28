class YouTubePlayer extends Factory
	constructor: ($rootScope, $window, $log) ->
		apiReady = false
		players = {}

		$window.onYouTubeIframeAPIReady = =>
			apiReady = true

			$rootScope.$broadcast playerId for playerId, videoId of players

			players = null

		createPlayer = (playerId, videoId, playlistId, playerHeight, playerWidth) ->
			options =
				height  : playerHeight
				width   : playerWidth
				videoId : videoId

			if playlistId
				options.playerVars =
					listType: 'playlist'
					list: playlistId

			player = new YT.Player playerId, options

		return class YouTubePlayerInstance
			constructor: (playerId, videoId, playlistId, playerHeight='390', playerWidth='640') ->
				getPlayer = ->
					player = createPlayer playerId, videoId, playlistId, playerHeight, playerWidth

				if apiReady
					@player = getPlayer()
				else
					players[playerId] = videoId

					deregister = $rootScope.$on playerId, (e) =>
						@player = getPlayer()

						deregister()

				@destroy = ->
					@player.destroy()