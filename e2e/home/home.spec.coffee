HomePage = require './HomePage'

describe 'Home Page', ->
	beforeEach ->
		@page = new HomePage()
		@page.visitPage()

	it 'should have title', ->
		expect(@page.getTitle()).toEqual('fatarrow')
