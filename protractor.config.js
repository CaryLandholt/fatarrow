exports.config = {
	specs: ['e2e/**/*.spec.coffee'],
	capabilities: {
		browserName: 'phantomjs',
		'phantomjs.binary.path': 'node_modules/phantomjs/bin/phantomjs'
  	},
	baseUrl: 'http://localhost:8181'
};
