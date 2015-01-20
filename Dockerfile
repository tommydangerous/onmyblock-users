FROM onmyblock/ruby:2.1.5
MAINTAINER OnMyBlock development@onmyblock.com

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
