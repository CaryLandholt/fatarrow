karma     = require 'karma'
notify    = require('../utils').notify
path      = require 'path'

module.exports = (gulp, plugins) -> ->
	karma.server.start {configFile: path.join __dirname, '../../karma.conf.coffee'}, (code) ->
		if code > 0
			notify 'Karma tests failed', false
		else
			notify 'Karma tests passed', true
