notify    = require('../utils').notify
path      = require 'path'
{E2E_DIRECTORY} = require '../constants'

module.exports = (gulp, plugins) -> ->
	testsErrored = no
	sources = '**/*.spec.{coffee,js}'

	options =
		protractor:
			configFile: './protractor.conf.coffee'

	str = gulp
		.src sources, {cwd: E2E_DIRECTORY, read: false}
		.pipe plugins.protractor.protractor options.protractor

	str.on 'error', ->
		testsErrored = yes
		process.exit 1
	str.on 'close', (code) ->
		process.exit 0 unless testsErrored
		testsErrored = no
