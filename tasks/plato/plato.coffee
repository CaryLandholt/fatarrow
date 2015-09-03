browserSync = require 'browser-sync'
del = require 'del'
es = require 'event-stream'
{DIST_DIRECTORY, TEMP_DIRECTORY, SRC_DIRECTORY, STATS_DIST_DIRECTORY} = require '../constants'
{ngClassifyOptions}   = require '../options'
templateOptions = require '../templateOptions'
plato = require 'plato'
{options} = require '../../config/plato'

module.exports = (gulp, plugins) -> ->
	{onError} = require('../events') plugins

	sources = [ STATS_DIST_DIRECTORY ]

	del(sources).then ->
		plato.inspect "#{DIST_DIRECTORY}/**/*.js", STATS_DIST_DIRECTORY, options, ->
			browserSync
				server:
					baseDir: STATS_DIST_DIRECTORY
