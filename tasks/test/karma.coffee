karma     = require 'karma'
notify    = require('../utils').notify
{citest}  = require '../options'
{options} = require '../../config/karma'

module.exports = (gulp, plugins) -> ->
	karma.server.start options, (code) ->
		if citest
			process.exit code if code
			return

		if code > 0
			notify 'Karma tests failed', false
		else
			notify 'Karma tests passed', true
