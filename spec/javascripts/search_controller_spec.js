describe('SearchController', function () {
  var $scope, mock;

  beforeEach(module('Application'));

  beforeEach(function () {

    mock = {
      search: function(terms) {
        return [
          {
            positions: [
              {title: 'CEO', organization: 'Microsoft'}
            ]
          }, 
          {
            position: [
              {title: 'Programmer', organization: 'Facebook'}
            ]
          }
        ]
      }
    };

    spyOn(mock, 'search').andCallThrough();

    module(function($provide) {
      $provide.value('SearchService', mock);
    });
  });
  
  beforeEach(inject(function ($rootScope, $controller) {
    $scope = $rootScope.$new();
    $controller('SearchController', {$scope: $scope});
  }));


  it('should call FilterService with a proper array', function() {
    $scope.search = 'CEO, Microsoft';
    $scope.update()
    expect(mock.search).toHaveBeenCalledWith($scope.search);
  });

  it('should list all profiles with empty search', function() {
    $scope.search = '';
    $scope.update();
    expect(mock.search).toHaveBeenCalledWith('');
  });
  
  
});

