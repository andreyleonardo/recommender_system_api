require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RecommenderSystem
  class Application < Rails::Application
    # We only need the CORS rules in development. In staging and production
    # the rules are configured in nginx
    if Rails.env.development?
      config.middleware.insert_before 'Rack::Runtime', 'Rack::Cors' do
        allow do
          origins '*'
          resource '*',
            headers: :any,
            methods: [:get, :put, :post, :patch, :delete, :options]
        end
      end
    end

    config.generators do |generate|
      # DISABLE ASSET GENERATORS
      generate.javascript_engine false
    end

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.autoload_paths += %W(#{config.root}/lib) + %W(#{config.root}/app/services) + \
                             %W(#{config.root}/app/services/recommender_system)
  end
end
