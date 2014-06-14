module.exports = class
	constructor: ->
		usernameField = element By.model   'controller.username'
		fullName      = element By.binding '{{controller.reportCard.name}}'

		@fillUsername = (username) ->
			usernameField.sendKeys username

		@getFullName = ->
			fullName.getText()

		@search = ->
			usernameField.sendKeys protractor.Key.ENTER

		@visitPage = ->
			browser.get '/#/reportcard'