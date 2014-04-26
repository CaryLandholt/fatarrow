class Syntax extends Directive
	constructor: (syntaxHighlighterService) ->
		link = (scope, element, attrs) ->
			language = scope.language
			lineNumbers = scope.lineNumbers isnt 'false'

			code = element.html()
				.replace /</gm, '&lt;'
				.replace />/gm, '&gt;'
				.replace /\t/gm, '  '

			newlineCharCode = '\n'.charCodeAt 0

			# remove leading newlines
			code = code.substr 1 while code.charCodeAt(0) is newlineCharCode

			# last line number (zero-based)
			last = code.length - 1

			# remove trailing newlines
			code = code.substr 0, last while code.charCodeAt(last) is newlineCharCode

			html = syntaxHighlighterService.highlight code, language, lineNumbers

			element.html html

		return {
			link
			replace: true
			restrict: 'E'
			scope:
				language: '@'
				lineNumbers: '@'
		}