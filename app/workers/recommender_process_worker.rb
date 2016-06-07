class RecommenderProcessWorker
  include Sidekiq::Worker
  def perform
    logger.info 'Processing Recommenders Database'
    start = Time.zone.now
    recommender = MovieRecommender.new
    recommender.clean!
    recommender.add_movies_to_matrix
    recommender.add_users_to_matrix
    logger.info Time.zone.now - start
    logger.info 'Data Added to the Matrix'
    logger.info 'Processing Processing Similarities'
    start = Time.zone.now
    recommender.process!
    logger.info Time.zone.now - start
  end
end
