describe 'markdown', ->
	describe 'markdown directive', ->
		beforeEach module 'app'

		beforeEach inject (@$compile, $rootScope) ->
			@scope = $rootScope.$new()

		it 'renders html from a single line of markdown', ->
			markup = """
			<markdown>
			# fatarrow
			</markdown>
			"""

			element    = @$compile(markup)(@scope)
			controller = element.controller()
			html       = element.html()
			expected   = '<h1 id="fatarrow">fatarrow</h1>'

			expect html
				.toEqual expected

		it 'renders html from multiple lines of markdown', ->
			markup = """
			<markdown>
			# fatarrow
			## Table of Contents
			</markdown>
			"""

			element    = @$compile(markup)(@scope)
			controller = element.controller()
			html       = element.html()

			expected = """
			<h1 id="fatarrow">fatarrow</h1>

			<h2 id="tableofcontents">Table of Contents</h2>
			"""

			expect html
				.toEqual expected