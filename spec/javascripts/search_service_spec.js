describe('SearchService', function () {
  var SearchService, data, $httpBackend;

  beforeEach(module('Application.services'));

  beforeEach(function () {

    data = [
      {
        first_name: 'Vahur',
        last_name: 'Roosimaa'
      },
      {
        first_name: 'Googley',
        last_name: 'Googler'
      },
      {
        first_name: 'Facey',
        last_name: 'Facebooker'
      }
    ];    

    inject(function($injector) {
      $httpBackend = $injector.get('$httpBackend');
      SearchService = $injector.get('SearchService');
    });
  });

  afterEach(function () {
    $httpBackend.verifyNoOutstandingExpectation();
    $httpBackend.verifyNoOutstandingRequest();
  });
  
  it('should return 3 results with "Google"', function () {
    var result;

    $httpBackend.expectGET('/search/Google').respond(200, JSON.stringify(data));
    SearchService.search('Google').then(function (results) {
      result = results;
    });
    $httpBackend.flush();

    expect(result.length).toEqual(3);
  });

  it("should return 0 results with empty search", function() {
    expect(SearchService.search('').length).toEqual(0);
  });
  
});

