require 'sidekiq'

host = '127.0.0.1'
port = '6379'

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{host}:#{port}/0" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{host}:#{port}/0" }
end
