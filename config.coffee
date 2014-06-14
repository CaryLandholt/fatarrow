APP_NAME = 'app'

BOWER_COMPONENTS =
	'angular': '1.2.18':
		scripts: 'angular.min.js'
	'angular-mocks': '1.2.18':
		scripts: 'angular-mocks.js'
	'angular-route': '1.2.18':
		scripts: 'angular-route.min.js'
	'bootstrap': '3.1.1':
		fonts:   'dist/fonts/**/*.{eot,svg,ttf,woff}'
		styles:  'dist/css/*.min.css'
	'google-code-prettify': '1.0.1':
		scripts: 'src/prettify.js'
		styles:  'src/prettify.css'
	'showdown': '0.3.1':
		scripts: 'src/showdown.js'

SCRIPTS = [
	'**/angular.min.js'
	'**/angular-mocks.js'
	'**/angular-route.min.js'
	'**/app.js'
	'**/*.js'
]

STYLES = [
	'**/bootstrap.min.css'
	'**/bootstrap-theme.min.css'
	'**/*.css'
]

module.exports = {APP_NAME, BOWER_COMPONENTS, SCRIPTS, STYLES}