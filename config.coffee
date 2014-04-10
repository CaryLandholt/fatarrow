APP_NAME = 'app'

BOWER_COMPONENTS =
	'angular'              : '1.3.0-beta.5':
		scripts               : 'angular.min.js'
	'angular-animate'      : '1.3.0-beta.5':
		scripts               : 'angular-animate.min.js'
	'angular-mocks'        : '1.3.0-beta.5':
		scripts               : 'angular-mocks.js'
	'angular-route'        : '1.3.0-beta.5':
		scripts               : 'angular-route.min.js'
	'bootstrap'            : '3.1.1':
		fonts                 : 'dist/fonts/**/*.{eot,svg,ttf,woff}'
		styles                : 'dist/css/*.min.css'
	'google-code-prettify' : '1.0.1':
		scripts               : 'src/prettify.js'
		styles                : 'src/prettify.css'

SCRIPTS = [
	'**/angular.min.js'
	'**/angular-mocks.js'
	'**/angular-animate.min.js'
	'**/angular-route.min.js'
	'app/app.js'
	'**/*.js'
]

STYLES = [
	'**/bootstrap.min.css'
	'**/bootstrap-theme.min.css'
	'**/*.css'
]

module.exports = {APP_NAME, BOWER_COMPONENTS, SCRIPTS, STYLES}