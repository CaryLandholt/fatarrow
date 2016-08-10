angular = require 'angular'
Showdown = require 'showdown'

class Markdown extends Service
	constructor: () ->
		@converter = new Showdown.Converter()

	convert: (content) ->
		html = @converter.makeHtml content

module.exports = Markdown
