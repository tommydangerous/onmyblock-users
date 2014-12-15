require File.expand_path("../boot", __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module Base
  class Application < Rails::Application
    config.cache_store = :redis_store, "#{ENV["REDIS_URL"]}/0/cache"

    config.autoload_paths += Dir[Rails.root.join("app", "services", "{**/}")]

    # Add application specific config below this line
  end
end
