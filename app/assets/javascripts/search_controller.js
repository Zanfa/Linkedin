'use strict';

angular.module('Application', ['Application.services', 'Application.controllers'])
  .config(['$parseProvider', function ($parseProvider) {
    $parseProvider.unwrapPromises(true);
  }])
  .directive('searchController', function () {
    return {
      restrict: 'E',
      templateUrl: 'templates/search_controller.html'
    }
  })
  .controller('SearchController', ['$scope', 'SearchService', function ($scope, SearchService) {
    $scope.search = '';
    $scope.profiles = SearchService.search($scope.search);

    $scope.update = function () {
      $scope.profiles = SearchService.search($scope.search);
    };

    $scope.try = function (search) {
        $scope.search = search;
        $scope.update();
    }
  }]);

