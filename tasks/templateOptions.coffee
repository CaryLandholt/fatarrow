{APP_NAME}               = require '../config/app'
{isProd, useBackendless} = require './options'
module.exports =
	appName: APP_NAME
	isProd: isProd
	useBackendless: useBackendless
	scripts: []
	styles: []
