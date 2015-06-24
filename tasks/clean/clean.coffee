del = require 'del'
{BOWER_DIRECTORY} = require '../constants'

module.exports = (gulp, plugins) -> (cb) ->
	{onError} = require('../events') plugins

	sources = BOWER_DIRECTORY
	del sources, (err) ->
		cb err
