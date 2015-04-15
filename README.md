# Docker Rails Template

This is my basic Rails app template for beginning development with Docker.

- Rails version: 4.2.1
- Ruby version: 2.2.0

Docker images used:

- [passenger-docker](https://github.com/phusion/passenger-docker)
- [postgres](https://registry.hub.docker.com/_/postgres/)
- [redis](https://registry.hub.docker.com/_/redis/)

It runs the application as the `app` user. The database owner is the
`myapp_user`. To customize this template, grep for `myapp` and replace all
occurrences.

## Preparing the Environment

First, decide which environment you wish to use. Copy the selected environment
file into `.env`. For example:

    cp .env.development .env

Be sure to define any of the environment variables without values.

Any added environment variables must also be added to `rails-env.conf` so that
they're exposed to Nginx child processes ([more info](https://github.com/phusion/passenger-docker#setting-environment-variables-in-nginx)).

## Running

[Docker Compose](https://docs.docker.com/compose/) is used for linking containers.

First, build the included Dockerfiles:

    docker-compose build

Then, start the web app:

    docker-compose up

Finally, create the database:

    docker exec myapp_web_1 bin/rake db:create

Further commands can be executed in this way.

The app is exposed on port 80 by default. If using
[Boot2Docker](https://github.com/boot2docker/boot2docker), enter its IP
address in your browser.

## Sidekiq

This template uses [Sidekiq](https://github.com/mperham/sidekiq) for background
processing. A Redis container is linked to enable Sidekiq to work. Once the app
is started, Sidekiq provides a monitoring tool at `/sidekiq`.

To start Sidekiq and process jobs: `bin/sidekiq`

[Sidetiq](https://github.com/tobiassvn/sidetiq) is used to create scheduled
jobs. Scheduled jobs should go under `app/workers/scheduled/` and will be
automatically loaded even in the development environment.

## Testing

For TDD, this template includes the following:

- [rspec-rails](https://github.com/rspec/rspec-rails)
- [factory_girl_rails](https://github.com/thoughtbot/factory_girl_rails)
- [shoulda](https://github.com/thoughtbot/shoulda)
- [faker](https://github.com/stympy/faker)

## Production

Be sure to create:

- `SECRET_BASE_KEY` via `bin/rake secret`
- `myapp_prod_user` with a password for `MYAPP_PROD_USER_DATABASE_PASSWORD`

## Tips

`docker-compose up` will create a Docker 'web' container named `<base-directory-name>_web_1`.

The following Bash function:

    # ddo -> 'docker-do'
    function ddo { docker exec -it `basename $PWD | sed s/[-_]//g`_web_1 $* }

allows:

    # Create the database
    ddo bin/rake db:create

    # Run specs
    ddo bin/rspec

    # Start a Bash login shell
    ddo bash -l
