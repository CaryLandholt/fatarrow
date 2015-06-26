modRewrite = require 'connect-modrewrite'
url = require 'url'
browserSync = require 'browser-sync'
{PROXY_CONFIG} = require '../../config'
{DIST_DIRECTORY} = require '../constants'
{open} = require '../options'
{FONTS, IMAGES, SCRIPTS, SOURCEMAPS, STYLES, VIEWS} = require '../extensions'
PORT = 8181

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

console.log 'expression', expression

module.exports = ->
	return if browserSync.active

	modRewriteConfig = [
		'^/img/.*$ - [L]'
		'^/fonts/.*$ - [L]'
		"^(#{expression})$ - [L]"
		'^.*$ /index.html [L]'
	].concat PROXY_CONFIG

	browserSync
		open: open
		port: PORT
		server:
			baseDir: DIST_DIRECTORY
			middleware: [
				modRewrite modRewriteConfig
			]
	, ->
		firstRun = false
