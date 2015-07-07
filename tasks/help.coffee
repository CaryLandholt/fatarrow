yargs          = require 'yargs'
updateNotify   = require('./updateNotify/updateNotify')()

module.exports = (gulp) -> (done) ->
	console.log '\n' + yargs.help()
	done()
