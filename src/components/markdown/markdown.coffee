class Markdown extends Directive
	constructor: (markdownService) ->
		link = (scope, element, attrs) ->
			code = element.text()
			html = markdownService.convert code

			element.html html

		return {
			link
			replace: true
			restrict: 'E'
		}