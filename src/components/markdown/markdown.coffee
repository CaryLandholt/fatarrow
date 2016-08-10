angular = require 'angular'

class Markdown extends Directive
	constructor: (markdownService) ->
		link = (scope, element, attrs) ->
			code = element.text()
			html = markdownService.convert code

			element.html html

		return {
			replace: true
			link
			restrict: 'E'
		}

module.exports = Markdown