Simple app for displaying a bunch of photos (wedding or otherwise) built using angular.

# Testing
- Run `grunt test` to run unit tests
- For end-to-end testing, running in the dist directory, use `grunt e2e`

# Use your own Pictures
To use your own pictures, you will need a directory somewhere on your machine which contains said pics. This directory will need a file `manifest.json` which will contain json following with a top-level root object `pictures` which contains an array of objects representing each picture. A picture has two values: `thumb` and `full`:

```
{
  "pictures" : [
    { 
      "thumb" : "pictures/thumbs/A&G Wedding-1001.jpg",
      "full" : "pictures/full/A&G Wedding-1001.jpg"
    },
    { 
      "thumb" : "pictures/thumbs/A&G Wedding-1100.jpg",
      "full" : "pictures/full/A&G Wedding-1100.jpg"
    },
    { 
      "thumb" : "pictures/thumbs/A&G Wedding-1122.jpg",
      "full" : "pictures/full/A&G Wedding-1122.jpg"
    }
  ]
}
```
To run locally using these pictures run the following:
```
grunt serve:dist --picture-source=ABSOLUTE_PATH_TO_PICTURES_DIRECTORY
```

# Deployment
This app uses capistrano to deploy to other servers. To deploy to a server, edit the environment file using whatever server credentials you need, and use `cap ENV deploy` to deploy the code. This will populate the `dist/` directory, tar it up, scp it over and expand it. In addition, you will need to upload your pictures to your server. To do so, use `cap pictures:upload source=ABSOLUTE_PATH_TO_PICTURES_DIRECTORY` which will tar and expand your picture directory, and replace the app symlink on the server to point to this new directory. These steps can be broken down for more control. heck `cap -T` and check the pictures namespace for more info.