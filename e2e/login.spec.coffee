require 'protractor/jasminewd'
require 'jasmine-given'

LoginPage = require './LoginPage'

describe 'app', ->
	page = new LoginPage()

	describe 'visiting the login page', ->
		Given ->
			page.visitPage()

		describe 'when a user logs in', ->
			Given ->
				page.fillEmail 'testy@example.com'

			Given ->
				page.fillPassword()

			When ->
				page.login()

			Then ->
				page.getCurrentUser().then (text) ->
					expect(text).toEqual 'Luke Skywalker'