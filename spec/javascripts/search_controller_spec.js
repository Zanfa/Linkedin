describe('SearchController', function () {
  var $scope, $testq, mock;

  beforeEach(module('Application'));

  beforeEach(function () {

    mock = {
      search: function(terms) {
        var deferred = $testq.defer();
        return deferred.promise; 
      }
    };


    module(function($provide) {
      $provide.value('SearchService', mock);
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
    expect(mock.search).toHaveBeenCalledWith($scope.search);
  });

  it('should list all profiles with empty search', function() {
    spyOn(mock, 'search').andCallThrough();
    $scope.search = '';
    $scope.update();
    expect(mock.search).toHaveBeenCalledWith('');
  });
  
  it('should set set loading flag while waiting for promise', function() {
    var deferred;

    deferred = $testq.defer();
    spyOn(mock, 'search').andReturn(deferred.promise);
    
    $scope.update();
    expect($scope.loading).toEqual(true);
    
    deferred.resolve([]);
    $scope.$apply();
    expect($scope.loading).toEqual(false);
  });

  it('should have intial firstSearch flag set, that gets unset when searched', function() {
    expect($scope.firstSearch).toEqual(true);
    $scope.update();
    expect($scope.firstSearch).toEqual(false);
  });
  
  
});

