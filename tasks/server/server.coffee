proxy = require 'proxy-middleware'
url = require 'url'
browserSync = require 'browser-sync'
{PROXY_CONFIG} = require '../../config'
{DIST_DIRECTORY} = require '../constants'
{open} = require '../options'
{PORT} = require './config'

module.exports = ->
	return if browserSync.active

	browserSync
		middleware: PROXY_CONFIG.map (config) ->
			options = url.parse config.url
			options.route = config.route
			proxy options
		open: open
		port: PORT
		server: DIST_DIRECTORY
	, -> firstRun = false
