modRewrite = require 'connect-modrewrite'
url = require 'url'
browserSync = require 'browser-sync'
{PROXY_CONFIG, PORT} = require '../../config/server'
{DIST_DIRECTORY} = require '../constants'
{useBackendless, open} = require '../options'
{FONTS, IMAGES, SCRIPTS, SOURCEMAPS, STYLES, VIEWS} = require '../extensions'

extensions = []
	.concat FONTS.COMPILED
	.concat IMAGES.COMPILED
	.concat SCRIPTS.COMPILED
	.concat SCRIPTS.UNCOMPILED
	.concat SOURCEMAPS.COMPILED
	.concat STYLES.COMPILED
	.concat STYLES.UNCOMPILED
	.concat VIEWS.COMPILED
	.concat VIEWS.UNCOMPILED

expression = extensions
	.map (x) -> ".*\\#{x}"
	.join '|'

module.exports = ->
	return if browserSync.active

	html5ModeConfig = [
		'^/img/.*$ - [L]'
		'^/fonts/.*$ - [L]'
		'^/vendor/.*$ - [L]'
		"^(#{expression})$ - [L]"
		'^.*$ /index.html [L]'
	]

	modRewriteConfig = []
		.concat (unless useBackendless then PROXY_CONFIG else [])
		.concat html5ModeConfig

	browserSync
		open: open
		port: PORT
		server:
			baseDir: DIST_DIRECTORY
			middleware: [
				modRewrite modRewriteConfig
			]
	require('../options').firstRun = false
