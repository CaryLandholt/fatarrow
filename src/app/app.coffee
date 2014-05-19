class App extends App
	@constructor = [
		'ngRoute'
		# coffeelint: disable=coffeescript_error
		<% if (!useBackend) { %>
		'ngMockE2E'
		<% } %>
		# coffeelint: enable=coffeescript_error
	]