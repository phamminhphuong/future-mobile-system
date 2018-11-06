require File.expand_path('../boot', __FILE__)
require_relative "boot"
require "rails/all"
require "csv"
Bundler.require(*Rails.groups)
module FutureMobileSystem
  class Application < Rails::Application
    config.load_defaults 5.2
    config.time_zone = Settings.time_zone
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
    config.autoload_paths += %W(#{config.root}/app/services)
  end
end
