jasmineReporters = require 'jasmine-reporters'

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
		# a better reporter for console
		jasmine.getEnv().addReporter(new jasmineReporters.TerminalReporter
			verbosity: 3,
			color: true,
			showStack: true
		)

		# this is for jenkins
		jasmine.getEnv().addReporter(
			new jasmineReporters.JUnitXmlReporter(
				consolidateAll: true,
				filePrefix: 'protractor-results'
				savePath: 'testResults'
			)
		)
