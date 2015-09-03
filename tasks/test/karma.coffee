karma     = require 'karma'
notify    = require('../utils').notify
path      = require 'path'
{firstRun} = require '../options'

module.exports = (gulp, plugins) -> ->
	func = if firstRun then karma.server.start else karma.server.run

	func {configFile: path.join __dirname, '../../karma.conf.coffee'}, (code) ->
		if code > 0
			notify 'Karma tests failed', false
		else
			notify 'Karma tests passed'
