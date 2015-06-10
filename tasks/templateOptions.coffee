{APP_NAME} = require '../config'
module.exports = (isProd, useBackendless) ->
	appName: APP_NAME
	isProd: isProd
	useBackendless: useBackendless
	scripts: []
	styles: []
