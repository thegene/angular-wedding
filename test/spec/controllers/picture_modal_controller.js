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
      pictureId: 7
    })
  }));

  it('has a single picture id', function(){
    expect(scope.pictureId).toBe(7);
  });
});