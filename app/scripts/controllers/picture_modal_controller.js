'use strict';

angular.module('angularWeddingApp')
  .controller('PictureModalCtrl', function($scope, $http, $modalInstance, 
      thumbnail, full){

    var fileName = function(full_file){
      return full_file.substring(full_file.lastIndexOf('/') + 1);
    }

    $scope.thumbnail = thumbnail;
    $scope.thumbName = fileName(thumbnail);

    $scope.full = full;
    $scope.fullName = fileName(full);

    $scope.close = function() {
      $modalInstance.close();
    }
});