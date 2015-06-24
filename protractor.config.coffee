exports.config =
	specs: ['e2e/**/*.spec.coffee']
	capabilities:
		browserName: 'phantomjs'
		'phantomjs.binary.path': if /^win/.test(process.platform) then 'node_modules\\.bin\\phantomjs.cmd' else 'node_modules/phantomjs/bin/phantomjs'
	baseUrl: "http://localhost:8181"
