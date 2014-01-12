describe('RegExp', function() {

	it('should match', function() {
		expect('string').toMatch(new RegExp('^string$'));
	});
	
	it('should return Hello', function () {
		expect(new TestThis().hello()).toMatch('Hello');
	});

	it('should return Vahur as name', function () {
		expect(new TestThis().name).toMatch('Vahur');
	});

	it('should return same string as argument', function() {
		expect(new TestThis().print('tere')).toEqual('tere');
	});
	
});
