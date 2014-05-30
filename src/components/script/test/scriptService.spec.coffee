describe 'script', ->
	describe 'scriptService', ->
		beforeEach module 'app'

		beforeEach inject (@$document, @scriptService) ->

		getScriptTag = (url) ->
			script = "<script src=\"#{url}\"></script>"

		it 'adds a script', ->
			url = '//foo/bar.js'

			@scriptService.add url

			html = @$document.find('body').html()

			expect html
				.toContain getScriptTag url

		it 'adds multiple scripts', ->
			url1 = '//foo/bar.js'
			url2 = '//biz/baz.js'

			@scriptService.add url1
			@scriptService.add url2

			html = @$document.find('body').html()

			expect html
				.toContain getScriptTag url1

			expect html
				.toContain getScriptTag url2

		it 'gets an array of scripts', ->
			url1 = '//foo/bar.js'
			url2 = '//biz/baz.js'

			@scriptService.add url1
			@scriptService.add url2

			scripts = @scriptService.get()
			isArray = Array.isArray scripts

			expect isArray
				.toEqual true

			expect isArray
				.not.toEqual false