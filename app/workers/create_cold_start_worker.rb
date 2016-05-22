class CreateColdStartWorker
  include Sidekiq::Worker
  def perform
    logger.info 'Creating Cold Starts'
    start = Time.zone.now
    recommender = MovieRecommender.new
    file = File.new('deleted_movies.txt', 'w')
    User.all.ids.sample(67).each do |user|
      ratings = Rating.find_best_ratings_by_user_id user
      next unless ratings
      recommender.create_cold_start_item ratings.first.movie_id
      file.write("user_id;#{ratings.first.user_id};movie_id;#{ratings.first.movie_id};movie_title;#{ratings.first.movie.title}\n")
      MovieDescriber.where(movie_id: ratings.first.movie_id).delete_all
      Rating.delete_movie_ratings ratings.first.movie_id
    end
    file.close
    logger.info Time.zone.now - start
  end
end
