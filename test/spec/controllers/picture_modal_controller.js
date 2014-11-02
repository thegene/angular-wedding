'use strict';

describe('Controller: PictureModalCtrl', function () {
  beforeEach(module('angularWeddingApp'));

  var Controller, scope, mockModalInstance;


  beforeEach(inject(function($controller, $rootScope){
    scope = $rootScope.$new();

    mockModalInstance = {
      close: function(){},
      dismiss: function(){},
      result: function(){}
    };

    Controller = $controller('PictureModalCtrl', {
      $scope: scope,
      $modalInstance: mockModalInstance,
      thumbnail: 'pictures/thumbs/some_thumb.jpg',
      full: 'pictures/full/some_full_pic.jpg'
    })
  }));

  describe('thumbnails', function(){
    it('has a thumbnail', function(){
      expect(scope.thumbnail).toBe('pictures/thumbs/some_thumb.jpg');
    });

    it('has a thumbName', function(){
      expect(scope.thumbName).toBe('some_thumb.jpg');
    });
  });

  describe('full size pictures', function() {
    it('has a full size picture file', function(){
      expect(scope.full).toBe('pictures/full/some_full_pic.jpg');
    });

    it('has a fullName', function(){
      expect(scope.fullName).toBe('some_full_pic.jpg');
    });
  });
});