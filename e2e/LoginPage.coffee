class LoginPage
	constructor: ->
		@emailField    = element By.input   'controller.username'
		@passwordField = element By.input   'user.password'
		@loginButton   = element By.id      'log-in'
		@currentUser   = element By.binding '{{currentUser.name}}'

	visitPage: ->
		browser.get '/#/reportcard'

	fillEmail: (email) ->
		@emailField.sendKeys email

	fillPassword: (password = 'password') ->
		@passwordField.sendKeys password

	login: ->
		@loginButton.click()

	getCurrentUser: ->
		@currentUser.getText()

module.exports = LoginPage