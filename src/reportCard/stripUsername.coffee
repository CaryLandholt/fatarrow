class StripUsername extends Filter
	constructor: ->
		return (repo, username) ->
			startsWithUsername = repo.toLowerCase().indexOf(username.toLowerCase()) is 0

			return repo if not startsWithUsername

			strippedRepo = repo.substr username.length + 1