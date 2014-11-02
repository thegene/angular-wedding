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
      thumbnail: 'pictures/thumbs/something.jpg'
    })
  }));

  it('has a thumbnail', function(){
    expect(scope.thumbnail).toBe('pictures/thumbs/something.jpg');
  });
});