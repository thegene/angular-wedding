'use strict';

/**
 * @ngdoc function
 * @name angularWeddingApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the angularWeddingApp
 */
angular.module('angularWeddingApp')
  .controller('MainCtrl', function ($scope) {
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];
  });
