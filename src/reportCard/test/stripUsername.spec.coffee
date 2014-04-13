describe 'reportCard', ->
	stripUsernameFilter = undefined
	username = 'CaryLandholt'

	beforeEach module 'app'

	beforeEach inject (_stripUsernameFilter_) ->
		stripUsernameFilter = _stripUsernameFilter_

	it 'strips the username from the repo, if the repo is by the user', ->
		repo = 'CaryLandholt/AngularFun'
		strippedUsernameFromRepo = stripUsernameFilter repo, username

		expect(strippedUsernameFromRepo).toEqual('AngularFun')
		expect(strippedUsernameFromRepo).not.toEqual(repo)

	it 'doesn not strip the username from the repo, if the repo by another user', ->
		repo = 'angular/angular.js'
		strippedUsernameFromRepo = stripUsernameFilter repo, username

		expect(strippedUsernameFromRepo).toEqual(repo)
		expect(strippedUsernameFromRepo).not.toEqual('angular.js')