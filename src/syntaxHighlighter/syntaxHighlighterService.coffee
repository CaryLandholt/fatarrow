class SyntaxHighlighter extends Service
	constructor: ($window) ->
		@process = $window.prettyPrintOne

	highlight: (code, language, lineNumbers = true) ->
		@process code, language, lineNumbers