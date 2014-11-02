'use strict';

angular.module('angularWeddingApp')
  .controller('PictureModalCtrl', function($scope, $http, $modalInstance, 
      thumbnail, full){

    var fileName = function(fullFile){
      return fullFile.substring(fullFile.lastIndexOf('/') + 1);
    };

    $scope.thumbnail = thumbnail;
    $scope.thumbName = fileName(thumbnail);

    $scope.full = full;
    $scope.fullName = fileName(full);

    $scope.close = function() {
      $modalInstance.close();
    };
});