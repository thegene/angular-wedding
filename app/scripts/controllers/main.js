'use strict';

/**
 * @ngdoc function
 * @name angularWeddingApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the angularWeddingApp
 */
angular.module('angularWeddingApp')
  .controller('MainCtrl', function ($scope, $modal, $http) {

    $http.get('pictures/manifest.json').success(function(data){
      $scope.pictures = data.pictures;
    });

    $scope.openModal = function(thumbnail, full){

      $modal.open({
        templateUrl: 'views/picture_modal.html',
        controller: 'PictureModalCtrl',
        resolve: {
          thumbnail: function() {
            return thumbnail;
          },
          full: function(){
            return full;
          } 
        }
      });

    };
  });
