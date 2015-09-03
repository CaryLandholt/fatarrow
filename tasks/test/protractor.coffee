notify    = require('../utils').notify
path      = require 'path'
{E2E_DIRECTORY} = require '../constants'

module.exports = (gulp, plugins) -> ->
	testsErrored = no
	{onError} = require('../events') plugins
	sources             = '**/*.spec.{coffee,js}'

	options =
		protractor:
			configFile: './protractor.conf.coffee'

	str = gulp
		.src sources, {cwd: E2E_DIRECTORY, read: false}
		.on 'error', onError

		.pipe plugins.protractor.protractor options.protractor

	str.on 'error', onError
	str.on 'error', ->
		testsErrored = yes
		notify 'Protractor tests failed', false
	str.on 'close', (code) ->
		notify "Protractor tests passed" unless testsErrored
		testsErrored = no
	str
