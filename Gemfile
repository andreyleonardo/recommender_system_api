source 'https://rubygems.org'

gem 'rails', '4.2.5.2'
gem 'rails-api', '~> 0.4.0'
gem 'active_model_serializers', '~> 0.8.3' # NOTE: not the 0.9
gem 'pg'
gem 'rubocop', require: false
gem 'devise', '~> 3.5.2'
gem 'puma'
gem 'jwt', '1.5.4'
gem 'simple_command'
gem 'rack-cors', require: 'rack/cors'
gem 'yettings', '~>0.1.1'

# Sidekiq gems
gem 'sidekiq', '3.4.2'
gem 'celluloid-io', '0.16.0'
gem 'ice_cube'

gem 'sidetiq'

gem 'letter_opener', group: :development
gem 'table_print'

# Recommender System gem
gem 'predictor'
gem 'hiredis'
gem 'sinatra', require: nil

gem 'themoviedb-api'
gem 'rest-client'

group :development do
  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false
  gem 'capistrano-sidekiq', require: false
end

group :development, :test do
  gem 'byebug'
  gem 'spring'
end
