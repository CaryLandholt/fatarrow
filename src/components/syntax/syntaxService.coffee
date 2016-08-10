angular = require 'angular'
require('google-code-prettify/bin/prettify.min.js', ['prettyPrintOne'])

class Syntax extends Service
	constructor: () ->
		@process = prettyPrintOne

	highlight: (code, language, lineNumbers = true) ->
		syntax = @process code, language, lineNumbers
		html   = "<pre class=\"prettyprint\"><code>#{syntax}</code></pre>"

module.exports = Syntax