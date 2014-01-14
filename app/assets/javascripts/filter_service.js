'use strict';

angular.module('Application.services', ['ngResource'])
	.factory('filterService', ['$resource', function ($resource) {
    var profiles = [], 
        status = {
          loading: true,
          total: 0
        };

    var resources = $resource('/connections').get(function () {
      profiles = resources.profiles;
      status.total = profiles.length;
      status.loading = false;
    });

    // Make sure no duplicate profiles make it to results
    function addToResults(results, profile) {
      if (results.indexOf(profile) == -1)
        results.push(profile);
    }

    // Allow matching of a number of search terms as well as single terms
    function matchesTerm(terms, target) {
      if (terms instanceof Array) {
        for (var i = 0, termsLen = terms.length; i < terms.length; i++) {
          if (matchesTerm(terms[i], target))
            return true; 
        }

        return false;
      } else {
        return target.match(new RegExp(terms, 'i')) !== null
      }
    }

    function filter(term) {
      var results = [], count = profiles.length; 

      // Shortcut for all results, speeds things up
      if (term === '') return profiles;

      for (var i = 0; i < count; i++) {
        var profile = profiles[i], 
            positions = profile.positions, 
            positionsLen = positions.length,
            position;

        // Search from positions
        for (var j = 0; j < positionsLen; j++) {
          position = positions[j];

          if (matchesTerm(term, position.title) || matchesTerm(term, position.organization)) 
            addToResults(results, profile);
        }
      }

      return results;
    }

    return {
      filter: filter,
      status: status
    };
    
	}]);

