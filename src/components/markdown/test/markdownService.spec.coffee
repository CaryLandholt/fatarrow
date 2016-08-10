MarkdownService = require '../markdownService'

fdescribe 'markdown', ->
	describe 'markdownService', ->
		# beforeEach module 'app'
		# markdownService = null

		beforeEach ->
			@markdownService = new MarkdownService()

		xit 'converts html from a single line of markdown', ->
			markdown = """
			# fatarrow
			"""

			html     = @markdownService.convert markdown
			expected = '<h1 id="fatarrow">fatarrow</h1>'

			expect html
				.toEqual expected

		xit 'converts html from multiple lines of markdown', ->
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