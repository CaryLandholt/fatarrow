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

jsHint =
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

module.exports = {jsHint}
