FROM phusion/passenger-ruby22:0.9.15
MAINTAINER Brian Ustas <brianustas@gmail.com>

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Remove the default Nginx site.
RUN rm /etc/nginx/sites-enabled/default

# Add the Nginx site and config.
ADD nginx.conf /etc/nginx/sites-enabled/myapp.conf
ADD rails-env.conf /etc/nginx/main.d/rails-env.conf

# Start Nginx and Passenger.
RUN rm -f /etc/service/nginx/down

# Expose the Nginx HTTP service.
EXPOSE 80

# Install gems
WORKDIR /tmp
ADD Gemfile /tmp/
ADD Gemfile.lock /tmp/
RUN bundle install

# Map the UID 1000 from the boot2docker VM to the app user
RUN usermod -u 1000 app

WORKDIR /home/app/myapp

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
