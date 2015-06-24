es = require 'event-stream'
pkg = require '../../package.json'
{DIST_DIRECTORY, TEMP_DIRECTORY, SRC_DIRECTORY, STATS_DIRECTORY} = require '../constants'
{ngClassifyOptions}   = require '../options'
templateOptions = require '../templateOptions'
plato = require 'plato'

module.exports = (gulp, plugins) -> ->
	{onError} = require('../events') plugins
	options =
		plato:
			title: "#{pkg.name} v#{pkg.version}"

	plato.inspect "#{DIST_DIRECTORY}/**/*.js", STATS_DIRECTORY, options.plato, ->
