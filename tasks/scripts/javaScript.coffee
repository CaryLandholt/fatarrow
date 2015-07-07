es                    = require 'event-stream'
getScriptSources      = require('../utils').getScriptSources
lintNotify          = require './reporters/lintNotify'
{COMPONENTS_DIRECTORY,
	TEMP_DIRECTORY,
	SRC_DIRECTORY}    = require '../constants'
PREDEFINED_GLOBALS = [
	'after'
	'afterEach'
	'angular'
	'before'
	'beforeEach'
	'describe'
	'expect'
	'inject'
	'it'
	'jasmine'
	'module'
	'spyOn'
	'xdescribe'
	'xit'
]
templateOptions       = require '../templateOptions'

module.exports = (gulp, plugins) -> ->
	{onError} = require('../events') plugins
	options =
		jsHint:
			camelcase: true
			curly: true
			eqeqeq: true
			forin: true
			freeze: true
			immed: true
			indent: 1
			latedef: true
			newcap: true
			noarg: true
			noempty: true
			nonbsp: true
			nonew: true
			plusplus: true
			undef: true
			unused: true
			predef: PREDEFINED_GLOBALS

	sources = getScriptSources '.js'
	srcs    = []

	srcs.push src =
		gulp
			.src sources, {cwd: SRC_DIRECTORY, nodir: true}
			.on 'error', onError

			.pipe plugins.template templateOptions
			.on 'error', onError

			.pipe plugins.jshint options.jsHint
			.on 'error', onError

			.pipe plugins.jshint.reporter 'default'
			.on 'error', onError

			.pipe lintNotify 'jshint'
			.on 'error', onError

	srcs.push src =
		gulp
			.src sources, {cwd: COMPONENTS_DIRECTORY, nodir: true}
			.on 'error', onError

	es
		.merge.apply @, srcs
		.on 'error', onError

		.pipe plugins.newer TEMP_DIRECTORY
		.on 'error', onError

		.pipe gulp.dest TEMP_DIRECTORY
		.on 'error', onError
