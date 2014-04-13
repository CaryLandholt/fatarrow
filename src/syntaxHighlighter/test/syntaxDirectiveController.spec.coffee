describe 'syntax', ->
	beforeEach module 'app'

	beforeEach inject (@$compile, $rootScope) ->
		@scope = $rootScope.$new()

	it 'should start with <pre> tag', ->
		html = "<syntax>name = 'Cary'</syntax>"
		element = @$compile(html)(@scope)
		controller = element.controller 'syntaxDirectiveController'
		output = element.html()

		expect(output.indexOf('<pre')).toEqual(0)