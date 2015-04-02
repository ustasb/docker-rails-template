# Docker Rails Template

This is a basic Rails app template for beginning development with Docker.

Docker images used:

- [passenger-docker](https://github.com/phusion/passenger-docker)
- [postgres](https://registry.hub.docker.com/_/postgres/)

It runs the application as the `app` user. The database owner is the
`myapp_user`. To customize this template, grep for `myapp` and replace all
occurrences.

## Running

The template uses [Docker Compose](https://docs.docker.com/compose/) for linking
containers.

First, build the included Dockerfiles:

    docker-compose build

Then, start the web app:

    docker-compose up

Finally, create the database:

    docker exec myapp_web_1 bin/rake db:create

Further commands can be executed in this way.

The app is exposed on port 80 by default. If using Boot2Docker, enter its IP
address in your browser.
