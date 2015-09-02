childProcess  = require 'child_process'
browserSync   = require 'browser-sync'
path          = require 'path'
notify        = require('../utils').notify
windowsify    = require('../utils').windowsify
yargs         = require 'yargs'

module.exports = (gulp, plugins) -> ->
	# launch karma in a new process to avoid blocking gulp
	command = windowsify '.\\node_modules\\.bin\\gulp.cmd', 'gulp'

	# get args from parent process to pass on to child process
	args  = ("--#{key}=#{value}" for own key, value of yargs.argv when key isnt '_' and key isnt '$0')
	args  = ['karma'].concat args
	karmaSpawn = childProcess.spawn command, args, {stdio: 'inherit'}
