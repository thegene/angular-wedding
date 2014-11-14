var generate = function(){
  h = [];

  for(i = 1; i <= 914; i++){
    pic = {
      'thumb' : url(i, 'thumbs'),
      'full' : url(i, 'full')
    };
    h.push(pic);
  };
  return {
    "pictures" : h
  };
}

var url = function(num, dir){
  return "http://wedding.eugenewestbrook.com/pictures/" + dir + "/A&G%20Wedding-" + (num + 1000) + ".jpg";
}


var hash = generate();
var string = JSON.stringify(hash, null, 4);

var fs = require('fs');
fs.writeFile('livePictures.json', string);