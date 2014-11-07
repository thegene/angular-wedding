'use strict';

describe('Main', function(){
  browser.get('http://localhost:9000/')
  var getPictureList = function() {
    return element.all(by.repeater('picture in pictures'));
  };

  describe('Picture List', function(){
    it('Has pictures', function(){
      expect(getPictureList().count()).toEqual(3);
    });
  });

  describe('Picture modal', function(){

    var clickOnPicture = function(){
      getPictureList().get(0).click();
    }

    it('displays a modal when clicked', function(){
      expect($('.picture-modal').isPresent()).toBe(false);
      clickOnPicture();
      expect($('.picture-modal').isPresent()).toBe(true);
      $('.picture-modal .close-picture').click();
      expect($('.picture-modal').isPresent()).toBe(false);
    });

    it('displays two download links when clicked', function(){
      clickOnPicture();
      expect(element.all(by.css('.download a')).count()).toEqual(2);
    });

  });

});