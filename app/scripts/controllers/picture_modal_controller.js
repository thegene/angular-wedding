'use strict';

angular.module('angularWeddingApp')
  .controller('PictureModalCtrl', function($scope, $http, thumbnail){
    $scope.thumbnail = thumbnail;
});