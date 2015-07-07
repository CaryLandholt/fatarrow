notify         = require('../utils').notify
updateNotifier = require 'update-notifier'
shell          = require 'shelljs'

module.exports = ->
	globals = shell.exec 'npm ls -g --depth=0 --json', { silent: true }
		.output

	packageInfo = JSON.parse globals
		.dependencies['generator-fatarrow']

	return unless packageInfo

	notifier = updateNotifier
		pkg:
			name: 'generator-fatarrow'
			version: packageInfo.version
		updateCheckInterval: 1000 * 60 * 60 * 24

	notifier.notify()
	if notifier.update?.latest
		notify "Fatarrow update available: #{notifier.update.latest} (current #{notifier.update.current})", false
