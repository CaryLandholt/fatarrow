describe 'reportCard', ->
	beforeEach module 'app'

	beforeEach inject (@stripUsernameFilter) ->

	it 'strips the username from the repo, if the repo is by the user', ->
		repo = 'CaryLandholt/AngularFun'
		username = 'CaryLandholt'
		strippedUsernameFromRepo = @stripUsernameFilter repo, username

		expect(strippedUsernameFromRepo).toEqual('AngularFun')
		expect(strippedUsernameFromRepo).not.toEqual(repo)

	it 'does not strip the username from the repo, if the repo by another user', ->
		repo = 'angular/angular.js'
		username = 'CaryLandholt'
		strippedUsernameFromRepo = @stripUsernameFilter repo, username

		expect(strippedUsernameFromRepo).toEqual(repo)
		expect(strippedUsernameFromRepo).not.toEqual('angular.js')