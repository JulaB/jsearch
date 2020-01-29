# Json file search &nbsp;&nbsp;&nbsp;&nbsp;[![Codeship Status for JulaB/jsearch](https://app.codeship.com/projects/48232120-2908-0137-97f3-6a22c15cbb13/status?branch=master)](https://app.codeship.com/projects/330918)

## Features
* exact search. Ex: "some phrase"
* contains search. Ex: several words
* exclude search with '-'. Ex: -search-word
* exact exclude search. Ex: -"Some phrase"

## Technologies
* Ruby 2.6.5
* Rails 5.2.2.1
* Node 10.15.0
* Yarn 1.21.1
* Minitest

## Run on Docker
### Prepare your Docker containers
* `docker-compose build`
* `docker-compose run --rm runner yarn install`
* `docker-compose run --rm runner ./bin/setup`

### Run rails server
* `docker-compose up rails webpacker`

### Run tests
* `docker-compose run --rm rails test`

## Run on local machine
### Install
* `yarn install`
* `bundle install`
* `rails test`

### Development
To run server in development `rails server`

### Running tests
* `rails test`

## Author
[Julia Bazhukhina](https://github.com/JulaB)

## License
MIT
