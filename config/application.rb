require_relative "boot"
require "rails/all"
Bundler.require(*Rails.groups)
module FutureMobileSystem
  class Application < Rails::Application
    config.load_defaults 5.2
    config.time_zone = Settings.time_zone
  end
end
