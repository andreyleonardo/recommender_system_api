require 'sidekiq'

Sidekiq.configure_server do |config|
  config.redis = { url: "#{Rails.application.secrets.redis}/0" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "#{Rails.application.secrets.redis}/0" }
end
