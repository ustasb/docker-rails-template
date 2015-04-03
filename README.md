# Docker Rails Template

This is a basic Rails app template for beginning development with Docker.

Docker images used:

- [passenger-docker](https://github.com/phusion/passenger-docker)
- [postgres](https://registry.hub.docker.com/_/postgres/)

It runs the application as the `app` user. The database owner is the
`myapp_user`. To customize this template, grep for `myapp` and replace all
occurrences.

## Preparing the Environment

First, decide which environment you wish to use. Make a symbolic link called
`.env` to the `.env.*` template you wish to use. For example:

    ln -s .env.development .env

Be sure to define any of the environment variables without values.

## Running

[Docker Compose](https://docs.docker.com/compose/) is used for linking containers.

First, build the included Dockerfiles:

    docker-compose build

Then, start the web app:

    docker-compose up

Finally, create the database:

    docker exec myapp_web_1 bin/rake db:create

Further commands can be executed in this way.

The app is exposed on port 80 by default. If using Boot2Docker, enter its IP
address in your browser.

## Production

Be sure to create:

- `SECRET_BASE_KEY` via `bin/rake secret`
- `myapp_prod_user` with a password for `MYAPP_PROD_USER_DATABASE_PASSWORD`
