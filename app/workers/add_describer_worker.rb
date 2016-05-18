class AddDescriberWorker
  include Sidekiq::Worker
  def perform(movie_id)
    logger.info 'Adding Movie Describers to Matrix'
    start = Time.zone.now
    movie = Movie.find(movie_id)
    DescribersProcessor.create_describers_for movie
    recommender = MovieRecommender.new
    recommender.add_describers_to_matrix movie_id
    logger.info Time.zone.now - start
  end
end
