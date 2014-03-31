class Syntax extends Directive
	constructor: ->
		return {
			controller: 'syntaxDirectiveController'
			locals:
				syntax: '@'
			replace: true
			restrict: 'E'
			scope:
				language: '@'
				lineNumbers: '@'
		}