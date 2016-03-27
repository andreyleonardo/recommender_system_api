class RecommenderProcessWorker
  include Sidekiq::Worker
  def perform
    Rails.logger.info('Processing Recommenders Database')
    puts "@@@@@@@"
    recommender = MovieRecommender.new
    recommender.clean!
    recommender.add_users_to_matrix
    recommender.add_movies_to_matrix
    recommender.process!
  end
end