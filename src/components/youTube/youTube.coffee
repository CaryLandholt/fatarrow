class YouTube extends Directive
	constructor: ($log, YouTubePlayer) ->
		uniqueIdPrefix = 'you-tube-player-'
		uniqueId       = 0

		return {
			compile: (tElement, tAttrs, transclude) ->
				id = tAttrs.id

				if not id
					id        = "#{uniqueIdPrefix}#{uniqueId}"
					uniqueId += 1

					tElement.attr 'id', id

				(scope, element, attrs) ->
					player = new YouTubePlayer id, scope.video, scope.playlist

					scope.$on '$destroy', ->
						player.destroy()

			replace: true
			restrict: 'E'
			scope:
				playlist: '@'
				video: '@'
		}