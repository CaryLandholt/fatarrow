APP_NAME = 'app'

BOWER_COMPONENTS =
	'angular': '1.2.20':
		scripts: 'angular.min.js'
	'angular-animate': '1.2.20':
		scripts: 'angular-animate.min.js'
	'angular-mocks': '1.2.20':
		scripts: 'angular-mocks.js'
	'angular-route': '1.2.20':
		scripts: 'angular-route.min.js'
	'angular-loading-bar': '0.4.3':
		scripts: 'build/loading-bar.min.js'
		styles:  'build/loading-bar.min.css'
	'bootstrap': '3.2.0':
		fonts:   'dist/fonts/**/*.{eot,svg,ttf,woff}'
		styles:  'dist/css/*.min.css'
	'google-code-prettify': '1.0.1':
		scripts: 'src/prettify.js'
		styles:  'src/prettify.css'
	'showdown': '0.3.1':
		scripts: 'src/showdown.js'

SCRIPTS = [
	'**/angular.min.js'
	'**/angular-animate.min.js'
	'**/angular-mocks.js'
	'**/angular-route.min.js'
	'**/loading-bar.min.js'
	'**/app.js'
	'**/*.js'
]

STYLES = [
	'**/bootstrap.min.css'
	'**/bootstrap-theme.min.css'
	'**/*.css'
]

module.exports = {APP_NAME, BOWER_COMPONENTS, SCRIPTS, STYLES}