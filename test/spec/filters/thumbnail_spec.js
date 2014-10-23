describe('Thumbnail filter', function() {
  beforeEach(module('weddingFilters'));

  describe('thumbnail', function() {

    it('builds thumbnail images from phone ids', 
        inject(function(weddingThumbnailFilter){
      expect(weddingThumbnailFilter(2))
        .toBe('pictures/thumbs/A&G Wedding-2.jpg');
    }));
  });
});