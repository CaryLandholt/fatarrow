yargs = require 'yargs'
module.exports = (gulp) -> (done) ->
	console.log '\n' + yargs.help()
	done()
