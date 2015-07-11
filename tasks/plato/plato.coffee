es = require 'event-stream'
{DIST_DIRECTORY, TEMP_DIRECTORY, SRC_DIRECTORY, STATS_DIRECTORY} = require '../constants'
{ngClassifyOptions}   = require '../options'
templateOptions = require '../templateOptions'
plato = require 'plato'
{options} = require '../../config/plato'

module.exports = (gulp, plugins) -> ->
	{onError} = require('../events') plugins

	plato.inspect "#{DIST_DIRECTORY}/**/*.js", STATS_DIRECTORY, options, ->
