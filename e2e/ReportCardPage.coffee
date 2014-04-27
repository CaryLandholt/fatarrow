class ReportCardPage
	constructor: ->
		@usernameField =  element By.input   'controller.username'
		@reportCardName = element By.binding '{{controller.reportCard.name}}'

		@fillUsername = (username) ->
			@usernameField.sendKeys username

		@getReportCardName = ->
			@reportCardName.getText()

		@submit = ->
			@usernameField.sendKeys protractor.Key.ENTER

		@visitPage = ->
			browser.get '/#/reportcard'

module.exports = ReportCardPage