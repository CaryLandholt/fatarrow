describe 'markdown', ->
	describe 'markdownService', ->
		beforeEach module 'app'

		beforeEach inject (@markdownService) ->

		it 'converts html from a single line of markdown', ->
			markdown = """
			# fatarrow
			"""

			html     = @markdownService.convert markdown
			expected = '<h1 id="fatarrow">fatarrow</h1>'

			expect html
				.toEqual expected

		it 'converts html from multiple lines of markdown', ->
			markdown = """
			# fatarrow
			## Table of Contents
			"""

			html = @markdownService.convert markdown

			expected = """
			<h1 id="fatarrow">fatarrow</h1>

			<h2 id="tableofcontents">Table of Contents</h2>
			"""

			expect html
				.toEqual expected