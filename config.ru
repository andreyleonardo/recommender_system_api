# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)
run Rails.application

Sidekiq::Web.use Rack::Session::Cookie, secret: 'SOMETHING SECRET'
Sidekiq::Web.instance_eval { @middleware.rotate!(-1) }
