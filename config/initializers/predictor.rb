Predictor.redis = Redis.new(url: ENV['PREDICTOR_REDIS'])

Predictor.redis = Redis.new(url: ENV['PREDICTOR_REDIS'], driver: :hiredis)
