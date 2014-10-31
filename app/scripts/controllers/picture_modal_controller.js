'use strict';

angular.module('angularWeddingApp')
  .controller('PictureModalCtrl', function($scope, $modalInstance, pictureId){
    $scope.pictureId = pictureId;
});