class Markdown extends Service
	constructor: (@$window) ->
		@converter = new @$window.Showdown.converter()

	convert: (content) ->
		html = @converter.makeHtml content