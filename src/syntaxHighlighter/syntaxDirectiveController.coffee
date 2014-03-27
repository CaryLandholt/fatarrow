class SyntaxDirective extends Controller
	constructor: ($scope, $transclude, $sce, syntaxHighlighterService) ->
		language = $scope.language
		lineNumbers = $scope.lineNumbers isnt 'false'
		code = $transclude().text().replace(/\t/gm, '    ')
		newlineCharCode = '\n'.charCodeAt 0

		if code.charCodeAt(0) is newlineCharCode
			code = code.substr 1

		last = code.length - 1

		if code.charCodeAt(last) is newlineCharCode
			code = code.substr 0, last

		syntax = syntaxHighlighterService.highlight code, language, lineNumbers
		$scope.syntax = $sce.trustAsHtml syntax