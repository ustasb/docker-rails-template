FROM phusion/passenger-ruby22:0.9.15
MAINTAINER Brian Ustas <brianustas@gmail.com>

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Map the UID 1000 from the Boot2Docker VM to the 'app' user.
RUN usermod -u 1000 app

# Install gems
WORKDIR /tmp
ADD Gemfile /tmp/
ADD Gemfile.lock /tmp/
RUN bundle install

# Remove the default Nginx site.
RUN rm /etc/nginx/sites-enabled/default

# Add the Nginx config.
ADD nginx.conf /etc/nginx/sites-enabled/myapp.conf
# Tell Nginx which environment variables to preserve. By default, it clears all
# except for TZ for its child processes.
ADD rails-env.conf /etc/nginx/main.d/rails-env.conf

# Start Nginx and Passenger.
RUN rm -f /etc/service/nginx/down

# Expose the Nginx HTTP service.
EXPOSE 80

WORKDIR /home/app/myapp

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
