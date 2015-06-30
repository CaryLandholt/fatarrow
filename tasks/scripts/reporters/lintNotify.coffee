es = require 'event-stream'
notify = require('../../utils').notify

module.exports = (type = 'jshint') ->
	count = 0
	countFiles = (data) ->
		@emit 'data', data
		count++ unless data[type].success

	endStream = ->
		notify "#{type} reported #{count} files with linting errors", false if count > 0
		@emit 'end'

	es.through countFiles, endStream
