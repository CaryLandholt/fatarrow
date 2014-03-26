class SyntaxHighlighter extends Service
	constructor: ($window) ->
		@hljs = $window.hljs

	highlight: (code, language) ->
		return if language
			@hljs.highlight language, code

		@hljs.highlightAuto code