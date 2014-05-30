describe 'script', ->
	describe 'toExtension filter', ->
		beforeEach module 'app'

		beforeEach inject (@toExtensionFilter) ->

		it 'replaces the extension', ->
			getScript = (ext) ->
				script = "foo/bar#{ext}"

			sourceExt = '.js'
			source    = getScript sourceExt
			targetExt = '.coffee'
			filtered  = @toExtensionFilter source, targetExt
			script    = getScript targetExt

			expect filtered
				.toEqual script

			expect filtered
				.not.toEqual source