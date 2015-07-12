module.exports = class
	constructor: ->
		@visitPage = ->
			browser.get '/'
		@getTitle = ->
			browser.getTitle()
