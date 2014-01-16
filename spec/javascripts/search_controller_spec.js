describe('SearchController', function () {
  var $scope, $testq, mock, deferred;

  beforeEach(module('Application'));

  beforeEach(function () {

    mock = {
      search: function(id, terms) {
        deferred = $testq.defer();
        return deferred.promise; 
      }
    };

    $window = {
      pool: {
        id: 1,
        inviteUrl: 'www.example.com',
        profileCount: 100
      }
    };


    module(function($provide) {
      $provide.value('SearchService', mock);
      $provide.value('$window', $window);
    });
  });
  
  beforeEach(inject(function ($q, $rootScope, $controller) {
    $testq = $q;
    $scope = $rootScope.$new();
    $controller('SearchController', {$scope: $scope});
  }));


  it('should call FilterService with a proper array', function() {
    spyOn(mock, 'search').andCallThrough();
    $scope.search = 'CEO, Microsoft';
    $scope.update()
    expect(mock.search).toHaveBeenCalledWith(1, $scope.search);
  });

  it('should do nothing with empty search', function() {
    spyOn(mock, 'search').andCallThrough();
    $scope.search = '';
    $scope.update();
    expect(mock.search).not.toHaveBeenCalledWith(1, '');
  });
  
  it('should set set loading flag while waiting for promise', function() {
    var deferred;

    deferred = $testq.defer();
    spyOn(mock, 'search').andReturn(deferred.promise);
    
    $scope.search = 'Google';
    $scope.update();
    expect($scope.loading).toEqual(true);
    
    deferred.resolve([]);
    $scope.$apply();
    expect($scope.loading).toEqual(false);
  });

  it('should have intial firstSearch flag set, that gets unset when searched', function() {
    expect($scope.firstSearch).toEqual(true);
    $scope.search = 'Google';
    $scope.update();
    expect($scope.firstSearch).toEqual(true);

    deferred.resolve([]);
    $scope.$apply();
    expect($scope.firstSearch).toEqual(false);
    
  });
  
  
});

