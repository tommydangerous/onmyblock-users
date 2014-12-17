source "https://rubygems.org"

gem "rails", "4.1.8"

gem "active_model_serializers"
gem "airbrake"
gem "analytics-ruby", require: "segment"
gem "attr_extras"
gem "bson_ext"
gem "dotenv-rails"
gem "foreman"
gem "mongoid"
gem "newrelic_rpm"
gem "payload", require: "payload/railtie"
gem "puma-rails"
gem "redis-rails"

gem "coffee-rails", "~> 4.1.0"
gem "jquery-rails"
gem "sass-rails", "~> 4.0"
gem "turbolinks"
gem "uglifier", ">= 1.3.0"

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "bundler-audit", require: false
  gem "license_finder", require: false
  gem "pry-rails"
  gem "pry-byebug"
  gem "quiet_assets"
  gem "rubocop", require: false
  gem "rubocop-rspec", require: false
end

group :development, :test do
  gem "factory_girl_rails"
  gem "rspec-rails"
  gem "spring"
  gem "spring-commands-rspec"
end

group :test do
  gem "database_cleaner"
  gem "faker"
  gem "mongoid-rspec", "~> 2.0.0.rc1"
  gem "rspec-instafail"
  gem "shoulda"
  gem "simplecov"
end

# Add application specific gems below this line
