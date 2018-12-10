# Membership System

[![Build Status](https://travis-ci.org/darren987469/membership-system.svg?branch=master)](https://travis-ci.org/darren987469/membership-system)
[![Maintainability](https://api.codeclimate.com/v1/badges/b0cb26d0fbddb0624aa0/maintainability)](https://codeclimate.com/github/darren987469/membership-system/maintainability)
[![Coverage Status](https://coveralls.io/repos/github/darren987469/membership-system/badge.svg?branch=master)](https://coveralls.io/github/darren987469/membership-system?branch=master)

Use cases and system design information is at [system spec](docs/system_spec.md)

## API document

Production: [HOST]/swagger
Development: http://localhost:3000/swagger

## Install

```shell
bundle                # install gems
rails db:setup        # create db and seed
rails s               # start server in http://localhost:300

# postgres db
brew install postgresql
brew services start postgresql
```

### Use Docker to build environment

```sh
docker-compose build
docker-compose up

docker-compose run web rake db:setup

docker-compose down

# after change Gemfile or Compose file, rebuild it
docker-compose up --build
docker-compose run web bundle install # sync changes to Gemfile.lock

# shell of containers
docker-compose run web sh
```

Reference: https://docs.docker.com/compose/rails

## Development

### Install git hook

To ensure code style and quality, we use `rubocop` to check style and `rspec` to test. Install `overcommit` to install git hook for you.

```sh
overcommit --install  # add git hook tool
overcommit --sign     # apply git hook. execute it after changing .overcommit.yml
```

Before committing, git hook run `rubocop`. Before pushing, git hook run `rspec`. Setting file is at [.overcommit.yml](.overcommit.yml)

Ignore git hook: `SKIP=RuboCop git commit`

### Development flow

Basically follow [git flow]((http://nvie.com/posts/a-successful-git-branching-model/)).

1. Create a new branch to solve an issue in [issues page](https://github.com/darren987469/membership-system/issues).
2. Open a Pull Request. Make sure CI test pass.
3. After reviewing and approving, merge the Pull Request.

## Testing

```shell
bundle exec rake
```

## Deploy

```sh
heroku login

git remote add heroku https://git.heroku.com/membership-system.git
git push heroku master

heroku open
```

Reference: https://devcenter.heroku.com/articles/getting-started-with-rails5
