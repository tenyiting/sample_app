require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SampleApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    config.load_defaults 5.2
    config.i18n.available_locales = [:en, :ja]
    config.i18n.default_locale = :en
    config.action_view.embed_authenticity_token_in_remote_forms = true
  end
end
