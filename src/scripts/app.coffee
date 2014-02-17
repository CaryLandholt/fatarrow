class App extends App
	@constructor = [
		'ngAnimate'
		<% if (environment === 'dev') { %>'ngMockE2E'<% } %>
		'ngRoute'
	]