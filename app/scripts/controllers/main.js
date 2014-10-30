'use strict';

/**
 * @ngdoc function
 * @name angularWeddingApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the angularWeddingApp
 */
angular.module('angularWeddingApp')
  .controller('MainCtrl', function ($scope, $modal) {
    $scope.pictureIds = [1001, 1100, 1122];

    $scope.openModal = function(pictureId){

      var modalInstance = $modal.open({
        templateUrl: 'views/picture_modal.html',
        controller: 'PictureModalCtrl',
        resolve: {
          pictureId: function() {
            return pictureId;
          }
        }
      });

    };
  });
