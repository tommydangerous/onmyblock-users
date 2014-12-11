FROM ubuntu:14.04
MAINTAINER OnMyBlock development@onmyblock.com

# Set rbenv related environment variables
ENV PATH /root/.rbenv/bin:/root/.rbenv/shims:$PATH
ENV RBENV_ROOT /root/.rbenv

# Install packages required to build and install Ruby
RUN apt-get update && \
    apt-get -y install build-essential git wget libreadline-dev libssl-dev libxml2-dev libyaml-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install rbenv to manage ruby versions
RUN git clone --depth=1 https://github.com/sstephenson/rbenv.git /root/.rbenv && \
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc

# Install the ruby-build plugin which builds and installs different ruby versions
RUN git clone --depth=1 https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build && \
    /root/.rbenv/plugins/ruby-build/install.sh

# Install the default-gems plugin which automatically installs specified gems when ruby versions are installed
RUN git clone --depth=1 https://github.com/sstephenson/rbenv-default-gems.git /root/.rbenv/plugins/rbenv-default-gems && \
    echo "bundler" >> /root/.rbenv/default-gems

# Install the gem-rehash plugin which calls `rbenv rehash` anytime a system gem is installed
RUN git clone --depth=1 https://github.com/sstephenson/rbenv-gem-rehash.git /root/.rbenv/plugins/rbenv-gem-rehash

# Add default options when gem installing dependencies
RUN echo "gem: --no-rdoc --no-ri" >> ~/.gemrc && \
    echo "backtrace: true" >> ~/.gemrc && \
    echo "benchmark: false" >> ~/.gemrc && \
    echo "bulk_threshold: 5" >> ~/.gemrc && \
    echo "update_sources: false" >> ~/.gemrc && \
    echo "verbose: true" >> ~/.gemrc

# Generate the /app directory which is where the Rails application will be mounted
RUN mkdir /app
WORKDIR /app
VOLUME /app

# Add /app/bin to $PATH
ENV PATH /app/bin:$PATH

# Set the Ruby version for this app
ENV RUBY_VERSION 2.1.5

# Install the specified Ruby version globally
RUN rbenv install $RUBY_VERSION && \
    rbenv global $RUBY_VERSION

# Configure bundler to install gems to a specific path
RUN bundle config --global path /app/vendor/bundle

# Install packages required for the Rails application
# libsqlite3-dev is used for the license_finder gem
RUN apt-get update && \
    apt-get -y install nodejs libsqlite3-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Start foreman by default when running a container
CMD bundle exec foreman start
