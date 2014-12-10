### Description
This repository is the base app for all other service applications.

### Setup
When you clone a child repository, make sure you add this as an upstream.
```
$ git remote add upstream git@github.com:onmyblock/rails.git
```

### App Setup
#### Bundle install
```
$ fig run --rm app bundle install
```

### Rails Console
```
$ fig run --rm app rails console
```

### Testing
```
$ fig run --rm app rspec
```

### Setting up new models
When you create a new model, add `include MongoModel` to the class.
```
class User
  include MongoModel
end
```
