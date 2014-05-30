class Syntax extends Directive
	constructor: ($http, $templateCache, syntaxService) ->
		link = (scope, element, attrs) ->
			language        = scope.language
			lineNumbers     = scope.lineNumbers isnt 'false'
			src             = scope.src
			hasSrc          = src?

			sanitize = (input) ->
				input
					.replace /</gm, '&lt;'
					.replace />/gm, '&gt;'
					.replace /\t/gm, '  '

			return if hasSrc
				$http.get src, {cache: $templateCache}
				.success (response) ->
					includeFilename = scope.includeFilename isnt 'false'
					isCoffeeScript  = src.indexOf('.coffee') isnt -1

					if includeFilename
						getComment = (src) ->
							return "# #{src}" if isCoffeeScript
							return "// #{src}" if src.indexOf('.js') isnt -1
							return "<!-- #{src} -->" if src.indexOf('.html') isnt -1
							return ''

						comment  = getComment src
						response = "#{comment}\n" + response if comment isnt ''

					code = sanitize response
					html = syntaxService.highlight code, language, lineNumbers

					element.html html

			code = sanitize element.html()

			newlineCharCode = '\n'.charCodeAt 0

			# remove leading newlines
			code = code.substr 1 while code.charCodeAt(0) is newlineCharCode

			# last line number (zero-based)
			last = code.length - 1

			# remove trailing newlines
			code = code.substr 0, last while code.charCodeAt(last) is newlineCharCode

			html = syntaxService.highlight code, language, lineNumbers

			element.html html

		return {
			link
			replace: true
			restrict: 'E'
			scope:
				includeFilename: '@'
				language: '@'
				lineNumbers: '@'
				src: '@'
		}