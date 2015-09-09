childProcess  = require 'child_process'
browserSync   = require 'browser-sync'
path          = require 'path'
notify        = require('../utils').notify
windowsify    = require('../utils').windowsify
yargs         = require 'yargs'

module.exports = (gulp, plugins) -> ->
	gulp.start 'karma'
