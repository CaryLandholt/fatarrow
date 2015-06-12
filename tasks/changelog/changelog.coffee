fs = require 'fs'
{CHANGELOG_FILE} = require '../constants'
conventionalChangelog = require 'conventional-changelog'
pkg = require '../../package.json'
module.exports = (gulp, plugins) -> ->
	options =
		repository: pkg.repository.url
		version: pkg.version
		file: CHANGELOG_FILE
		log: plugins.util.log

	conventionalChangelog options, (err, log) ->
		fs.writeFile CHANGELOG_FILE, log
