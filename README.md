# README


## Description

Welcome to Pochi App. This is my submission for the Quikk technical interview challenge
Pochi App is an API based web app built on Ruby on Rails that allows a user to sign up
and make subsequent requests through an authenticated API token to top up their wallet
and transfer funds to other users on the platform.
They can also request for a transaction report which will be sent to their email.

## Dependencies

- Postgres 14
- Ruby on Rails 7.1.2
- Ruby 3.2.2
- Bundler 2.4.10

## Setup local environment

- Ensure that you have all the dependencies installed.
- Run the `bundle` command.
- Run the `bin/rails db:setup` command.

## Local testing

- You can run the application by using the command `bin/rails s`.

## Production testing

The Pochi app is hosted on heroku [here](https://pochi-app-728bd426f8a4.herokuapp.com/)

## Postman documentation

The current API documentation can be found [here](https://api.postman.com/collections/7136436-e836be4f-c581-4cf4-ac35-f86def0018aa?access_key=PMAT-01HGTWAXEVTAGQ5D5Y6HS4ZBSA)
