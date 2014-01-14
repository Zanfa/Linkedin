'use strict';

angular.module('Application.controllers', [])
  .controller('ProfileController', ['$scope', function($scope) {

    $scope.active = false;

    $scope.toggle = function () {
      $scope.active = !$scope.active;
    };
  }]);
