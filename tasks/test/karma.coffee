karma     = require 'karma'
notify    = require('../utils').notify
{citest}  = require '../options'
{options} = require '../../config/karma'

module.exports = (gulp, plugins) -> ->
	karma.server.start options, (code) ->
		return if citest
		if code > 0
			notify 'Karma tests failed', false
		else
			notify 'Karma tests passed', true
