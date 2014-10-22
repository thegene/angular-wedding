var weddingFilters = angular.module('weddingFilters', []);

weddingFilters.filter('thumbnail', function(){
  return function(photoId){
    return 'pictures/thumbs/A&G Wedding-' + photoId + '.jpg'
  }
});