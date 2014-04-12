describe 'syntax', ->
	beforeEach module 'app'

	it 'something', inject ['stripUsernameFilter', (stripUsernameFilter) ->
		strippedUsername = stripUsernameFilter 'CaryLandholt/AngularFun', 'CaryLandholt'

		expect(strippedUsername).toEqual('AngularFun')
	]