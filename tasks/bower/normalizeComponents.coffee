es = require 'event-stream'
fs = require 'fs'
q = require 'q'
pkg = require '../../package.json'
{BOWER_DIRECTORY, BOWER_FILE, COMPONENTS_DIRECTORY, VENDOR_DIRECTORY} = require '../constants'
{BOWER_COMPONENTS} = require '../../config/bower'
path = require 'path'

module.exports = (gulp, plugins) -> ->
	{onError} = require('../events') plugins
	unless require('../options').firstRun
		deferred = q.defer()
		deferred.resolve()
		return deferred

	bowerComponents = do ->
		bowerJson =
			_comment: 'THIS FILE IS AUTOMATICALLY GENERATED.  DO NOT EDIT.'
			name: pkg.name
			version: pkg.version
			devDependencies: {}

		components = {}

		for component, value of BOWER_COMPONENTS
			for version, componentTypes of value
				bowerJson.devDependencies[component] = version

				for componentType, files of componentTypes
					isArray         = Array.isArray files
					filesToAdd      = if isArray then files else [files]
					filesToAdd      = filesToAdd.map (file) -> path.join component, file
					key             = path.join component, componentType
					components[key] = [] if not components[key]
					components[key] = components[key].concat filesToAdd

		fs.writeFile BOWER_FILE, JSON.stringify bowerJson, {}, '\t'

		components

	srcs = for componentType, sources of bowerComponents
		gulp
			.src sources, {cwd: BOWER_DIRECTORY, nodir: true}
			.on 'error', onError

			.pipe gulp.dest path.join COMPONENTS_DIRECTORY, VENDOR_DIRECTORY, componentType
			.on 'error', onError

	es.merge.apply @, srcs
