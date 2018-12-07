# Membership System

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

## Install

```shell
bundle                # install gems
overcommit --install  # add git hook tool
overcommit --sign     # apply git hook. execute it after changing .overcommit.yml
rails db:setup        # create db and seed
rails s               # start server in http://localhost:300
```

Ignore git hook: `SKIP=RuboCop git commit`

## Testing

```shell
bundle exec rspec
```