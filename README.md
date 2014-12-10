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

Before running your app, install the gems
```
$ fig run app bundle install
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

### Individual Service Description Below
---

### Models
When you create a new model, make it inherit from the `MongoModel` class.
```
class User < MongoModel
  ...
end
```

### Controllers
##### Creating new controllers
Subclass controller `UsersApplicationController`
```
class UsersController < UsersApplicationController
  ...
end
```

#### Using controllers
Use private method `render_json` to return your JSON.

### Tools
[Postman - REST Client](https://chrome.google.com/webstore/detail/postman-rest-client/fdmmgilgnpjigdojojpjoooidkmcomcm?hl=en)

### Tests
- Model: test database interaction
- Controller: test for response and status
- Service: test CRUD logic
- Serializer: test for correct data returned
