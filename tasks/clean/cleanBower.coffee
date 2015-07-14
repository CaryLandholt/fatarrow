del = require 'del'
{BOWER_DIRECTORY, BOWER_FILE} = require '../constants'
{getBower} = require '../options'

module.exports = (gulp, plugins) -> (cb) ->
	{onError} = require('../events') plugins

	sources = [].concat(if getBower and require('../options').firstRun then [BOWER_DIRECTORY, BOWER_FILE] else [])
	del sources, (err) ->
		cb err
