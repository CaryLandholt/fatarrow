ScreenShotReporter = require 'protractor-screenshot-reporter'
jasmineSpecReporter = require 'jasmine-spec-reporter'
jasmineReporters = require 'jasmine-reporters'
{citest} = require './tasks/options'

exports.config =
	specs: ['e2e/**/*.spec.coffee']
	framework: 'jasmine2'
	jasmineNodeOpts:
		silent: true
	capabilities:
		browserName: 'phantomjs'
		'phantomjs.binary.path': if /^win/.test(process.platform) then 'node_modules\\.bin\\phantomjs.cmd' else 'node_modules/phantomjs/bin/phantomjs'
	baseUrl: "http://localhost:8181"
	onPrepare: ->
		# take a screenshot when a test fails
		jasmine.getEnv().addReporter(
			new ScreenShotReporter(
				baseDirectory: 'protractorScreenshots'
				takeScreenShotsOnlyForFailedSpecs: true
			)
		)
		# a better reporter for console
		jasmine.getEnv().addReporter(
			new jasmineSpecReporter(
				displayStacktrace: true
				displaySpecDuration: true
			)
		)
		# this is for jenkins
		jasmine.getEnv().addReporter(
			new jasmineReporters.JUnitXmlReporter(
				consolidateAll: true,
				filePrefix: 'xmloutput'
				savePath: 'testResults'
			)
		)
