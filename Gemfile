source "https://rubygems.org"

gem "rails", "4.1.8"

# Load ENV variables from .env before loading other gems
gem "dotenv-rails", require: "dotenv/rails-now"

gem "airbrake"
gem "analytics-ruby"
gem "attr_extras"
gem "bson_ext"
gem "foreman"
gem "mongoid"
gem "newrelic_rpm"
gem "payload", require: "payload/railtie"
gem "puma"
gem "redis-rails"

gem "coffee-rails", "~> 4.1.0"
gem "jquery-rails"
gem "sass-rails", "~> 4.0"
gem "turbolinks"
gem "uglifier", ">= 1.3.0"

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "bundler-audit"
  gem "pry-rails"
  gem "pry-byebug"
  gem "quiet_assets"
end

group :development, :test do
  gem "factory_girl_rails"
  gem "rspec-rails"
  gem "spring"
end

group :test do
  gem "faker"
  gem "mongoid-rspec"
  gem "rspec-instafail"
  gem "shoulda"
end

# Add application specific gems below this line
