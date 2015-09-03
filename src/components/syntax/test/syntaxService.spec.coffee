describe 'syntax', ->
	describe 'syntaxService', ->
		beforeEach module 'app'

		beforeEach inject (@syntaxService) ->

		it 'renders highlighted html CoffeeScript', ->
			markdown = """
			name = 'Cary'
			"""

			html = @syntaxService.highlight markdown

			expect html.indexOf '<pre'
				.toEqual 0
