# Predictor.redis = Redis.new(url: ENV['PREDICTOR_REDIS'])

Predictor.redis = Redis.new(url: Rails.application.secrets.redis, driver: :hiredis)
