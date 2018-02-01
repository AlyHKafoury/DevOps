require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Drkiq
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.log_level = :debug
    config.log_tags  = [:subdomain, :uuid]
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
    #config.logger    = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))
    config.cache_store = :redis_store, ENV['CACHE_URL'],
                         { namespace: 'drkiq::cache' }
    config.active_job.queue_adapter = :sidekiq
  end
end
