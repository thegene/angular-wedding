'use strict';

describe('Controller: MainCtrl', function () {

  // load the controller's module
  beforeEach(module('angularWeddingApp'));

  var createController, scope, injector, mockBackend;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($injector) {
    injector = $injector;
    scope = $injector.get('$rootScope');
    mockBackend = injector.get('$httpBackend');

    createController = function(){ 
      injector.get('$controller')('MainCtrl', {
        $scope: scope
      });
    };
  }));

  describe('Given a MainCtrl', function(){
    it('has a modal', function() {
      createController();
      expect(scope.openModal).toBeDefined();
    });
  });

  describe('Given manifest file with 3 pictures', function() {
    var mockPicturesResponse = { 'pictures' : [
        {
          'thumb' : 'pictures/thumbs/blah.jpg'
        },
        {
          'thumb' : 'pictures/thumbs/foo.jpg'
        },
        {
          'thumb' : 'pictures/thumbs/bar.jpg'
        }
      ]};

    it('has pictures', function () {
      mockBackend.expectGET('pictures/pictures.json')
        .respond(mockPicturesResponse);
      createController();
      mockBackend.flush();
      expect(scope.pictures.length).toBe(3);
    });
  });
});
