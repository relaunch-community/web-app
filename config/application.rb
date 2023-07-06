require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RelaunchCommunity
  class Application < Rails::Application
    # Application Version
    VERSION = "0.0.0"

    # https://github.com/rails/tailwindcss-rails/issues/153
    config.assets.css_compressor = nil

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # https://stackoverflow.com/questions/36602764/how-to-use-npm-packages-in-rails
    config.assets.paths << Rails.root.join("node_modules")

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.fathom = { site_id: ENV.fetch("FATHOM_ANALYTICS_SITE_ID", "") }

    config.active_model.i18n_customize_full_message = true

    config.generators do |g|
      g.helper false
      g.test_framework :rspec, fixture: true
      # https://guides.rubyonrails.org/generators.html
      # https://stackoverflow.com/questions/11702265/can-factorybot-generate-factories-after-your-models-have-been-created
      g.fixture_replacement :factory_bot, suffix: "factory"
    end

    # https://edgeguides.rubyonrails.org/active_record_encryption.html
    config.active_record.encryption.support_unencrypted_data = true
    config.active_record.encryption.extend_queries = true

    # Use sidekiq as default, allow other envs to override if necessary
    config.active_job.queue_adapter = :sidekiq

    config.active_record.encryption.extend_queries = true
  end
end
