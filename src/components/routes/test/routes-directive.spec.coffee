describe 'routes', ->
	describe 'routes directive', ->
		beforeEach module 'app'
		beforeEach module 'components/routes/routes.html'

		beforeEach inject (@$compile, $rootScope) ->
			@scope = $rootScope.$new()

		it 'should have routes on scope', ->
			markup = """
			<routes></routes>
			"""

			el = angular.element markup

			element = @$compile(el)(@scope)

			@scope.$digest()

			routes = element.scope().routes

			expect routes
				.not.toBeNull()