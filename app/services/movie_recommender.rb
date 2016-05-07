# Predictor use 2 methods: similarities_for(:id) and find_predictions_for(item_set: [:ids])
# https://github.com/Pathgather/predictor
class MovieRecommender
  include Predictor::Base
  processing_technique(:lua)
  input_matrix :users, weight: 3.0
  input_matrix :genres, weight: 3.0
  input_matrix :ratings, weight: 1.0
  input_matrix :rates, weight: 2.0
  input_matrix :describers, weight: 1.0

  def add_movies_to_matrix
    Movie.find_each do |movie|
      unless movie.ratings.empty?
        movie.ratings.each do |r|
          add_to_matrix(:ratings, r.rating, movie.id)
        end
      end
      unless movie.genres.empty?
        movie.genres.each do |movie_genre|
          add_to_matrix(:genres, movie_genre.genre.id, movie.id)
        end
      end
      unless movie.describers.empty?
        movie.describers.each do |movie_describer|
          add_to_matrix(:describers, movie_describer.describer.id, movie.id)
        end
      end
      add_to_matrix(:rates, movie.rate, movie.id) unless movie.rate.nil?
    end
  end

  def add_users_to_matrix
    User.find_each do |user|
      unless user.ratings.empty?
        user.ratings.each do |r|
          add_to_matrix(:users, user.id, r.rating.movie_id)
        end
      end
    end
  end
end
