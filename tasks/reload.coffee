browserSync = require 'browser-sync'
{firstRun} = require './options'

module.exports = (gulp) -> ->
	browserSync.reload()
	firstRun = false;
