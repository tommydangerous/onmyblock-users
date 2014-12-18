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
### Making authenticated requests
Send each request with an access token in the X-Authorization HTTP Header

### Routes
Action | Method | Endpoint | Parameters
--- | --- | --- | ---
Create | POST | /api/v1/users | user[email, first_name, last_name, password]
Update | PUT/PATCH | /api/v1/users/:id | user[email, first_name, last_name, roles]
Login | POST | /api/v1/authentication | identification, password
Logout | DELETE | /api/v1/authentication | N/A
