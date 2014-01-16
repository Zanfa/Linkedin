'use strict';

angular.module('Application.services', [])
  .factory('SearchService', ['$q', '$http', function($q, $http) {
    
    var search = function (poolId, search) {
      if (search.length == 0) return [];

      var deferred = $q.defer();

      $http.get('/pools/' + poolId + '/search/' + search)
        .success(function(data, status, headers, config) {
          deferred.resolve(data);
        })
        .error(function (data, status, headers, config) {
          deferred.resolve([]);
        });

      return deferred.promise;
    }

    return {
      search: search 
    };

  }]);
