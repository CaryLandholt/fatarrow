proxy = require 'proxy-middleware'
url = require 'url'
browserSync = require 'browser-sync'
{PROXY_CONFIG} = require '../../config'
{DIST_DIRECTORY} = require '../constants'
{open} = require '../options'

exports.PORT = PORT = 8181

module.exports = ->
	return if browserSync.active

	bs = browserSync.create()

	bs.init
		middleware: PROXY_CONFIG.map (config) ->
			options = url.parse config.url
			options.route = config.route
			proxy options
		open: open
		port: PORT
		server: DIST_DIRECTORY
	, ->
		firstRun = false
