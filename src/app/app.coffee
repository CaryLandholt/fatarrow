class App extends App
	@constructor = [
		'ngRoute'
		# coffeelint: disable=coffeescript_error
		<% if (!isProd) { %>
		'ngMockE2E'
		<% } %>
		# coffeelint: enable=coffeescript_error
	]