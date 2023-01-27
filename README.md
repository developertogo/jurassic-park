![build & test & quality](https://github.com/cousins-factory/rails-api-boilerplate/actions/workflows/main.yml/badge.svg?branch=main)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
![Ruby Version](https://img.shields.io/badge/ruby_version-3.1.2-blue.svg)
![Rails Version](https://img.shields.io/badge/rails_version-7.0.4-c52f24.svg)

# Jurassic Park - RESTful Rails API

# Solution

## Introduction

The intend of this repo is to address the problem (assignment) described in [The Problem](#the-problem) section below.

## Design and Development Strategy

The source code is based on the [Rails API Boilerplate](https://github.com/shftco/rails-api-boilerplate). Although, it includes more gems that is required for this project, it has a great workflow handling of the HTTP request, see a diagram at [How to Works?](https://github.com/shftco/rails-api-boilerplate#how-to-works) section. The intend is to not crowd the controller or models with business logic. This _boilerplate_ is also a great starting point to expand the application with more features and functionalities later.

## Business Assumptions

Some [requirements](#business-requirements) which were not mentioned in the assignment are addressed below. The code can be easily refactored if the requirements changes.

* Use UUID for record IDs in order to avoid vulnerability attacks
* A cage has a unique tag name and location
* A cage cannot be deleted when it contains dinosaurs, i.e. not empty.
* A cage max capacity cannot be changed, it can only be set on create
* The max capacity of a cage is set to 100 for validation purposes. It's a constant variable and can easily make it configurable if it needs to
* The max capacity lowest value is 1
* A dinosaur name is unique

## Requirement

- [Ruby](https://rvm.io/) *v3.1.2*
- [PostgreSQL](https://www.postgresql.org/)
- [Redis](https://redis.io/)

## Installation

- Install GEM dependencies:

  ```bash
  bundle install
  ```

- Create database

  ```bash
  rails db:create
  ```

  **Note**:
  1. Connect to the `jurassic_park_development` database and ensure that you have the `pgcrypto` extension installed
     - This is how you check, do:

       ```SQL
       select * from pg_proc where proname like 'gen_random_%';
       ```

     - If the return is 0 rows, this means both functions: `gen_random_bytes` and `gen_random_uuid`, are not defined then you probably had an error with the extension creation, just drop it and recreate:

       ```SQL
       DROP EXTENSION pgcrypto;
       CREATE EXTENSION pgcrypto;
       ```

- Run migration scripts

  ```bash
  rails db:migrate
  ```

- Run seed migration script to populate the OAuth table:

  ```bash
  rails db:seed
  ```

- Run unit tests

   ```bash
   rails test [--verbose]
   ```

- Run the server

   ```bash
   ./bin/dev
   ```

- Connect to Swagger UI

   ```bash
  https://localhost:3000
   ```

- If you are setting up again, when you already have previous databases:

  ```bash
  rails db:reset
  ```

  `reset` is equivalent of `rails db:drop & rails db:setup`.
  &nbsp;

## Known Issues

1. Missing query parameters validation
   _Work is under progress_ using [dry-validation](https://dry-rb.org/gems/dry-validation/1.8/)

### Unit Tests Skipped

1. _Show resource APIs_: `v1/cages/{id}` and `v1/dinosaurs/{id}` were skipped because it keeps failing with this error `ActionController::RoutingError: No route matches [POST]` when indeed the routes clearly show they GET requests, see http://localhost:3000/rails/info/routes, when it's running.

## Running in a Concurrent Environment

When running in a concurrent environment, these changes need to be made:

1. For long running processes and to prevent blocking, queue them as background jobs with [Sidekiq](https://github.com/mperham/sidekiq) which is already included as part of the boilerplate template.
2. Configure the [Puma](https://github.com/puma/puma) web server that is already installed with this application. Puma uses threads to handle requests concurrently and pass them to the Rails application.
  a. Set the `ENV['WEB_CONCURRENCY']` environment variable to the number of child processes, default is `1`, `2` if there is enough memory.
  b. Set the  `ENV['RAILS_MAX_THREADS']` environment variable to the number of worker threads, default is `5`.
  For reference, see [Deploying Rails Applications with the Puma Web Server in Heroku](https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server)

---

## [The Problem](#the-problem)

It's 1993 and you're the lead software developer for the new Jurassic Park! Park operations needs a system to keep track of the different cages around the park and the different dinosaurs in each one. You'll need to develop a JSON formatted RESTful API to allow the builders to create new cages. It will also allow doctors and scientists the ability to edit/retrieve the statuses of dinosaurs and cages.

## [Business Requirements](#business-requirements)

Please attempt to implement the following business requirements:

- All requests should respond with the correct HTTP status codes and a response, if necessary, representing either the success or error conditions.
- Data should be persisted using some flavor of SQL.
- Each dinosaur must have a name.
- Each dinosaur is considered an herbivore or a carnivore, depending on its species.
- Carnivores can only be in a cage with other dinosaurs of the same species.
- Each dinosaur must have a species (See enumerated list below, feel free to add others).
- Herbivores cannot be in the same cage as carnivores.
- Use Carnivore dinosaurs like Tyrannosaurus, Velociraptor, Spinosaurus and Megalosaurus.
- Use Herbivores like Brachiosaurus, Stegosaurus, Ankylosaurus and Triceratops.

## Additional Requirement

- Cages have a maximum capacity for how many dinosaurs it can hold. Cages know how many dinosaurs are contained.
- Cages have a power status of ACTIVE or DOWN.
- Cages cannot be powered off if they contain dinosaurs.
- Dinosaurs cannot be moved into a cage that is powered down.
- Must be able to query a listing of dinosaurs in a specific cage.
- When querying dinosaurs or cages they should be filterable on their attributes (Cages on their power status and dinosaurs on species).
- Automated tests that ensure the business logic implemented is correct.