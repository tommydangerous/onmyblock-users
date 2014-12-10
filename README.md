### Description
This repository is the base app for all other service applications.

### Setup
When you clone a child repository, make sure you add this as an upstream.

```
$ git remote add upstream git@github.com:onmyblock/rails.git
```

Then you can pull in upstream changes by calling
```
$ git pull upstream master
```

### Running commands
Use `fig` to interact with the application containers.

```
$ fig run app rspec
```

```
$ fig run app rails console
```

```
$ fig run app foreman start
```

### Service Description Below

### Setting up new models
When you create a new model, add `include MongoModel` to the class.
```
class User
  include MongoModel
end
```
