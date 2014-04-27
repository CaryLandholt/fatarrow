ReportCardPage = require './ReportCardPage'

describe 'ReportCard Page', ->
	page = null

	beforeEach ->
		page = new ReportCardPage()

		page.visitPage()

	it 'should get the username', ->
		page.fillUsername 'CaryLandholt'
		page.submit()

		expect(page.getReportCardName()).toEqual('Cary Landholt')