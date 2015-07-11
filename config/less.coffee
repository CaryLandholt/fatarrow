path                = require 'path'
{TEMP_DIRECTORY,
	SRC_DIRECTORY}  = require '../tasks/constants'

options =
	paths: [
		path.resolve SRC_DIRECTORY
	]
	sourceMap: true
	sourceMapBasepath: path.resolve TEMP_DIRECTORY

module.exports = {options}
