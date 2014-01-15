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
    $scope.loading = false;
    $scope.firstSearch = true;
    $scope.search = '';
    $scope.profiles = [];

    $scope.update = function () {
      $scope.loading = true;
      $scope.firstSearch = false;

      SearchService.search($scope.search).then(function (profiles) {
        $scope.profiles = profiles;
        $scope.loading = false;
      });
    };

    $scope.try = function (search) {
        $scope.search = search;
        $scope.update();
    }
  }]);

