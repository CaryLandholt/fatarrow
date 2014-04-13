describe 'syntax', ->
	$compile                 = undefined
	controller               = undefined
	scope                    = undefined
	syntaxHighlighterService = undefined

	beforeEach module 'app'

	beforeEach inject (_$compile_, $rootScope, _syntaxHighlighterService_) ->
		$compile = _$compile_
		scope = $rootScope.$new()
		syntaxHighlighterService = _syntaxHighlighterService_

	it 'should start with <pre> tag', ->
		html = "<syntax>name = 'Cary'</syntax>"
		element = $compile(html)(scope)
		parameters = {$element: element, syntaxHighlighterService}
		controller = element.controller 'syntaxDirectiveController', parameters
		output = element.html()

		expect(output.indexOf('<pre')).toEqual(0)