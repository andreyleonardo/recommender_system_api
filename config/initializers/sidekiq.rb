require 'sidekiq'
require 'yettings'

host = Yetting.redis_host
port = Yetting.redis_port

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{host}:#{port}/0" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{host}:#{port}/0" }
end
