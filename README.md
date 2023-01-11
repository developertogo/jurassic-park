![Ruby Version](https://img.shields.io/badge/ruby_version-3.1.2-blue.svg)
![Rails Version](https://img.shields.io/badge/rails_version-7.0.4-c52f24.svg)

# Jurassic Park - RESTful Rails API

# Solution
This repo addresses the task described in [The Problem](#the-problem) section below. It's based on the [Rails API Boilerplate](https://github.com/shftco/rails-api-boilerplate). Although, it includes more gems that is required for this project, it includes a great handling of the HTTP request, see [How to Works?](https://github.com/shftco/rails-api-boilerplate#how-to-works) section. This _boilerplate_ is also a great starting point to expand the application with more features and functionalities later.

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

- If you are setting up again, when you already have previous databases:

  ```bash
  rails db:reset
  ```

  `reset` is equivalent of `rails db:drop & rails db:setup`.
  &nbsp;  

- Run the server

   ```bash
   ./bin/dev
   ```








---

## [The Problem](#the-problem)

It's 1993 and you're the lead software developer for the new Jurassic Park! Park operations needs a system to keep track of the different cages around the park and the different dinosaurs in each one. You'll need to develop a JSON formatted RESTful API to allow the builders to create new cages. It will also allow doctors and scientists the ability to edit/retrieve the statuses of dinosaurs and cages.

## Business Requirements

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