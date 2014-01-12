describe("MainCtrl", function() {
	var scope;

	beforeEach(module('Application'));

	beforeEach(inject(function ($rootScope, $controller) {
		scope = $rootScope.$new();

		$controller('MainCtrl', {$scope: scope});
	}));

	it('should have variable text = Hello, World', function() {
		expect(scope.text).toEqual('Hello, World');
	});
	
});

