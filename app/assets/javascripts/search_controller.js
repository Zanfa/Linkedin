'use strict';

angular.module('Application', ['Application.services', 'Application.controllers'])
  .config(['$parseProvider', function ($parseProvider) {
    $parseProvider.unwrapPromises(true);
  }])
  .directive('searchController', function () {
    return {
      restrict: 'E',
      templateUrl: '/templates/search_controller.html'
    }
  })
  .controller('SearchController', ['$scope', 'SearchService', '$window', 
              function ($scope, SearchService, $window) {
    $scope.loading = false;
    $scope.firstSearch = true;
    $scope.search = '';
    $scope.profiles = [];
    $scope.pool = $window.pool;

    $scope.update = function () {

      if ($scope.search.length == 0) return;

      $scope.loading = true;

      SearchService.search($scope.pool.id, $scope.search).then(function (profiles) {
        $scope.firstSearch = false;
        $scope.profiles = profiles;
        $scope.loading = false;
      });
    };

    $scope.try = function (search) {
        $scope.search = search;
        $scope.update();
    }
  }]);

