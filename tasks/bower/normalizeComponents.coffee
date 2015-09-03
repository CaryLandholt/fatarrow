es = require 'event-stream'
fs = require 'fs'
q = require 'q'
pkg = require '../../package.json'
{BOWER_DIRECTORY, BOWER_FILE, COMPONENTS_DIRECTORY, VENDOR_DIRECTORY} = require '../constants'
{BOWER_COMPONENTS} = require '../../config/bower'
path = require 'path'

module.exports = (gulp, plugins) -> ->
	{onError} = require('../events') plugins

	bowerComponents = do ->
		components = {}

		for component, value of BOWER_COMPONENTS
			for version, componentTypes of value
				for componentType, files of componentTypes
					isArray         = Array.isArray files
					filesToAdd      = if isArray then files else [files]
					filesToAdd      = filesToAdd.map (file) -> path.join component, file
					key             = path.join component, componentType
					components[key] = [] if not components[key]
					components[key] = components[key].concat filesToAdd

		components

	srcs = for componentType, sources of bowerComponents
		gulp
			.src sources, {cwd: BOWER_DIRECTORY, nodir: true}
			.on 'error', onError

			.pipe gulp.dest path.join COMPONENTS_DIRECTORY, VENDOR_DIRECTORY, componentType
			.on 'error', onError

	es.merge.apply @, srcs
