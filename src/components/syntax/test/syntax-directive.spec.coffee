describe 'syntax', ->
	describe 'syntax directive', ->
		beforeEach module 'app'

		beforeEach inject (@$compile, $rootScope) ->
			@scope = $rootScope.$new()

		it 'starts with the <pre> tag', ->
			markup = """
			<syntax>
			name = 'Cary'
			</syntax>
			"""

			element    = @$compile(markup)(@scope)
			controller = element.controller()
			html       = element.html()

			expect html.indexOf '<pre'
				.toEqual 0