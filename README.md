# Membership System

[![Build Status](https://travis-ci.org/darren987469/membership-system.svg?branch=master)](https://travis-ci.org/darren987469/membership-system)
[![Maintainability](https://api.codeclimate.com/v1/badges/b0cb26d0fbddb0624aa0/maintainability)](https://codeclimate.com/github/darren987469/membership-system/maintainability)
[![Coverage Status](https://coveralls.io/repos/github/darren987469/membership-system/badge.svg?branch=master)](https://coveralls.io/github/darren987469/membership-system?branch=master)

## Install

```shell
bundle                # install gems
rails db:setup        # create db and seed
rails s               # start server in http://localhost:300
```

## Development

### Install git hook

To ensure code style and quality, we use `rubocop` to check style and `rspec` to test. Install `overcommit` to install git hook for you.

```sh
overcommit --install  # add git hook tool
overcommit --sign     # apply git hook. execute it after changing .overcommit.yml
```

Before committing, git hook run `rubocop`. Before pushing, git hook run `rspec`. Setting file is at [.overcommit.yml](.overcommit.yml)

Ignore git hook: `SKIP=RuboCop git commit`

## Testing

```shell
bundle exec rspec
```