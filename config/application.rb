require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Slooly
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

    config.middleware.use Rack::Deflater

    config.generators do |generate|
      generate.test_framework :rspec,
                              fixtures: true,
                              view_specs: false,
                              helper_specs: false,
                              routing_specs: false,
                              controller_specs: false,
                              request_specs: false
      generate.fixture_replacement :factory_girl, dir: 'spec/factories'
      generate.assets = false
      generate.helper = false
    end

    config.exceptions_app = routes

    config.active_record.raise_in_transactional_callbacks = true

    config.active_job.queue_adapter = :delayed_job

    config.action_view.default_form_builder = "BootstrapFormBuilder"


    config.autoload_paths << Rails.root.join('lib')
  end
end
