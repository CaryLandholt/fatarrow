browserSync = require 'browser-sync'

module.exports = (gulp) -> ->
	browserSync.reload()
	require('./options').firstRun = false
