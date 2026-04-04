# PortoAPI

A RESTful API for making Portfolio.

API for making personal website's CMS. User can manage their own projects, journaling their experience(soon), and sharing everything on blog post(soon as well). User can draft the content before publishing.

## objects

- projects
- experiences
- blogs

## prerequisite

- ruby 3.3
- bundler 2.7
- docker-like (any container runtime)

## development

Install the deps:

```sh
bundle install
```

Seed the database:

```sh
bin/rails db:create
bin/rails db:seed:replant
bin/rails db:migrate
```

Start the server and create the user:

```sh
curl -X POST 127.1:3000/users -d '{"email_address":"user@example.com","password":"password","password_confirmation":"password","slug":"user"}'
```

Try logging in and get the token:

```sh
curl -X POST 127.1:3000/session -d '{"email_address":"user@example.com","password":"password"}'
```

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...
