'use strict';

/**
 * @ngdoc function
 * @name angularWeddingApp.controller:AboutCtrl
 * @description
 * # AboutCtrl
 * Controller of the angularWeddingApp
 */
angular.module('angularWeddingApp')
  .controller('AboutCtrl', function ($scope) {
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];
  });
