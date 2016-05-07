require 'sidekiq'

Sidekiq.configure_server do |config|
  config.redis = { url: "#{ENV['PREDICTOR_REDIS']}/0" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "#{ENV['PREDICTOR_REDIS']}/0" }
end
