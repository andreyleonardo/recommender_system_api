class UpdateMatrixWorker
  include Sidekiq::Worker
  def perform(user_id, movie_id, delete)
    logger.info 'Updating Matrix'
    start = Time.zone.now
    recommender = MovieRecommender.new
    if delete && !user_id.nil?
      recommender.delete_user_movie_from_matrix(user_id, movie_id)
    elsif delete
      file = File.new('deleted_movies.txt', 'w')
      User.all.ids.sample(67).each do |user|
        ratings = Rating.find_best_ratings_by_user_id user
        next unless ratings
        recommender.create_cold_start_item ratings.first.movie_id
        file.write("user_id: #{ratings.first.user_id},movie_id: #{ratings.first.movie_id}, movie_title: #{ratings.first.movie.title}\n")
        MovieDescriber.where(movie_id: ratings.first.movie_id).delete_all
        Rating.delete_movie_ratings ratings.first.movie_id
      end
      file.close
    else
      recommender.add_user_movie_to_matrix(user_id, movie_id)
    end

    # if delete
    #   DescribersProcessor.create_describers_for(movie_id)
    #   recommender.add_describers_to_matrix(movie_id)
    # end
    logger.info Time.zone.now - start
  end
end
