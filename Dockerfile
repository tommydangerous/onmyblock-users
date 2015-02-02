FROM docker.onmyblock.com:443/base:latest
#
MAINTAINER OnMyBlock development@onmyblock.com

# Generate the /app directory which is where the Rails application will be mounted
RUN mkdir /app
WORKDIR /app
VOLUME /app

# Add /app/bin to $PATH
ENV PATH /app/bin:$PATH

# Configure bundler to install gems to a specific path
RUN bundle config --global path /app/vendor/bundle

# Install packages required for the Rails application
# libsqlite3-dev is used for the license_finder gem
RUN apt-get update && \
    apt-get -y install nodejs libsqlite3-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Start foreman by default when running a container
CMD /app/bin/web
