class SyntaxDirective extends Controller
	constructor: ($element, syntaxHighlighterService) ->
		language = @language
		lineNumbers = @lineNumbers isnt 'false'

		code = $element.html()
			.replace /</gm, '&lt;'
			.replace />/gm, '&gt;'
			.replace /\t/gm, '  '

		newlineCharCode = '\n'.charCodeAt 0

		if code.charCodeAt(0) is newlineCharCode
			code = code.substr 1

		last = code.length - 1

		if code.charCodeAt(last) is newlineCharCode
			code = code.substr 0, last

		html = syntaxHighlighterService.highlight code, language, lineNumbers

		$element.html html