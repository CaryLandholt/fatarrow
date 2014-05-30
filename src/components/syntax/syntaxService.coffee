class Syntax extends Service
	constructor: ($window) ->
		@process = $window.prettyPrintOne

	highlight: (code, language, lineNumbers = true) ->
		syntax = @process code, language, lineNumbers
		html   = "<pre class=\"prettyprint\"><code>#{syntax}</code></pre>"