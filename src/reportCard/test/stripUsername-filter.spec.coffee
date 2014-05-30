describe 'reportCard', ->
	describe 'stripUsername filter', ->
		beforeEach module 'app'

		beforeEach inject (@stripUsernameFilter) ->

		it 'strips the username from the repo, if the repo is owned by the user', ->
			repo     = 'CaryLandholt/AngularFun'
			username = 'CaryLandholt'
			filtered = @stripUsernameFilter repo, username

			expect filtered
				.toEqual 'AngularFun'

			expect filtered
				.not.toEqual repo

		it 'does not strip the username from the repo, if the repo is owned by another user', ->
			repo     = 'angular/angular.js'
			username = 'CaryLandholt'
			filtered = @stripUsernameFilter repo, username

			expect filtered
				.toEqual repo

			expect filtered
				.not.toEqual 'angular.js'