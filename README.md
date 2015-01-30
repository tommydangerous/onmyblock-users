## Users
Users app

### Description
This repository is the base app for all other service applications.

### Setup
When you clone a child repository, make sure you add this as an upstream.

```
$ git remote add upstream git@github.com:onmyblock/rails.git
```

Then you can pull in upstream changes by calling:
```
$ git pull upstream master
```

Before running your app, install the gems:
```
$ fig run app bundle install
```

### Running commands

Use `fig` to interact with the application containers:
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
## Making authenticated requests
When making requests to authenticated endpoints, add a token in the
`OMB-Authorization` HTTP Header.

## Current API Version
version = v1

## Authentications
Action | Method | Endpoint | Parameters
--- | --- | --- | ---
Login | POST | /api/[version]/authentication | identification (email), password
Logout | DELETE | /api/[version]/authentication | N/A

## Credential Reset
Action | Method | Endpoint | Parameters
--- | --- | --- | ---
Create | POST | /api/[version]/credential/reset | identification (email)

## Credential Reset Update
Action | Method | Endpoint | Parameters
--- | --- | --- | ---
Create | POST | /api/[version]/credential/reset/update | password, token

## Credentials
Action | Method | Endpoint | Parameters
--- | --- | --- | ---
Update | PUT/PATCH | /api/[version]/credentials | token

## Users
Action | Method | Endpoint | Parameters
--- | --- | --- | ---
Create | POST | /api/[version]/users | email, first_name, last_name, password
Update | PUT/PATCH | /api/[version]/users/:id | email, first_name, id, last_name, roles
