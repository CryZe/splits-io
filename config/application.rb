require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module SplitsIO
  class Application < Rails::Application
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.action_controller.allow_forgery_protection = false
    config.active_job.queue_adapter = :delayed_job

    # How often should encountering a run trigger a background refresh-from-file job?
    config.run_refresh_chance = 0.1
  end
end

WillPaginate.per_page = 20
