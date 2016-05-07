class RecommenderProcessWorker
  include Sidekiq::Worker
  def perform
    puts 'Processing Recommenders Database'
    start = Time.zone.now
    recommender = MovieRecommender.new
    recommender.clean!
    recommender.add_movies_to_matrix
    recommender.add_users_to_matrix
    puts Time.zone.now - start
    puts 'Data Added to the Matrix'
    puts 'Processing Processing Similarities'
    start = Time.zone.now
    recommender.process!
    puts Time.zone.now - start
  end
end
