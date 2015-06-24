bower = require 'bower'
{firstRun} = require '../options'
{BOWER_DIRECTORY} = require '../constants'
{BOWER_COMPONENTS} = require '../../config'
q = require 'q'

module.exports = (gulp, plugins) -> ->
	{onError} = require('../events') plugins
	# we only want the bower task to run ones
	unless firstRun
		deferred = q.defer()
		deferred.resolve()
		return deferred

	firstRun = no

	options =
		directory: BOWER_DIRECTORY

	bowerOptions =
		forceLatest: true

	components = []

	urlExpression = /[-a-zA-Z0-9@:%_\+.~#?&//=]{2,256}\.[a-z]{2,4}\b(\/[-a-zA-Z0-9@:%_\+.~#?&//=]*)?/gi
	urlRegEx = new RegExp urlExpression

	for component, value of BOWER_COMPONENTS
		for version, files of value
			hasVersion = !!version

			if !hasVersion
				components.push component
				continue

			isUrl = version.match urlRegEx

			if isUrl
				components.push version
				continue

			components.push "#{component}##{version}"

	bower
		.commands.install components, bowerOptions, options
		.on 'error', onError
