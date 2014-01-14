describe('FilterService', function () {

	var filterService, data, $httpBackend;

  beforeEach(module('Application.services'));

	beforeEach(function () {

		data = {
      profiles: [
					{
            positions: [
              {title: 'CEO', organization: 'Google'},
              {title: 'Programmer', organization: 'Facebook'},
              {title: 'Software Developer', organization: 'Twitter'}
            ]
          },
          {
            positions: [
              {title: 'Manager', organization: 'Microsoft'},
              {title: 'Team Leader', organization: 'Scopely'}
            ]
          },
          {
            positions: [
              {title: 'Programmer', organization: 'Scopely'},
              {title: 'Programming Intern', organization: 'Scopely'}
            ]
          }
		]};

    inject(function($injector) {
      $httpBackend = $injector.get('$httpBackend');
      $httpBackend.expectGET('/connections').respond(data);
      filterService = $injector.get('filterService');
    });

    $httpBackend.flush();

	});

  it('should filter by organization', function() {
    expect(filterService.filter('Scopely').length).toEqual(2);
    expect(filterService.filter('Microsoft').length).toEqual(1);
  });
  
  it('should accept an array of terms for filter', function() {
    expect(filterService.filter(['Scopely', 'Microsoft']).length).toEqual(2);
  });

  it('should accept mixed titles and organizations', function() {
    expect(filterService.filter(['CEO', 'Scopely']).length).toEqual(3);
  });
  
  it('should be case-insensitive', function() {
    expect(filterService.filter(['ceO', 'SCOPELY']).length).toEqual(3);
  });

  it('should give all profiles for an empty search', function() {
    expect(filterService.filter('').length).toEqual(3);
  });
     
});

