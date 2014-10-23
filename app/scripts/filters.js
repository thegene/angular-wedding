'use strict';

var weddingFilters = angular.module('weddingFilters', []);

weddingFilters.filter('weddingThumbnail', function(){
  return function(photoId){
    return 'pictures/thumbs/A&G Wedding-' + photoId + '.jpg';
  };
});