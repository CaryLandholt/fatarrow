notify    = require('../utils').notify
path      = require 'path'
{E2E_DIRECTORY} = require '../constants'
{citest} = require '../options'

module.exports = (gulp, plugins) -> ->
	testsErrored = false
	{onError} = require('../events') plugins
	sources             = '**/*.spec.{coffee,js}'

	options =
		protractor:
			configFile: './config/e2e.coffee'

	str = gulp
		.src sources, {cwd: E2E_DIRECTORY, read: false}
		.on 'error', onError

		.pipe plugins.protractor.protractor options.protractor

	if citest
		str.on 'error', ->
			process.exit 1
		str.on 'end', ->
	else
		str.on 'error', onError
		str.on 'error', ->
			testsErrored = yes
			notify 'Protractor tests failed', false
		str.on 'close', (code) ->
			notify "Protractor tests passed", true unless testsErrored
			testsErrored = false
	str
