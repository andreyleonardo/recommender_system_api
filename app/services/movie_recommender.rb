# Predictor use 2 methods: similarities_for(:id) and find_predictions_for(item_set: [:ids])
# https://github.com/Pathgather/predictor
class MovieRecommender
  include Predictor::Base

  input_matrix :users, weight: 3.0
  input_matrix :ratings, weight: 3.0
  input_matrix :genres, weight: 2.0
  input_matrix :tags, weight: 1.0, measure: :sorensen_coefficient # Use Sorenson over Jaccard

  def add_movies_to_matrix    
    Movie.find_each do |movie|
      if !movie.ratings.empty?
        movie.ratings.each do |r|
          add_to_matrix(:ratings, r.rating, movie.id)
        end
      else
        add_to_matrix(:ratings, 0.0, movie.id)
      end
      unless movie.tags.empty?
        movie.tags.each do |tag|
          add_to_matrix(:tags, tag.tag, movie.id)
        end
      end
      unless movie.genres.empty?
        movie.genres.each do |movie_genre|
          add_to_matrix(:genres, movie_genre.genre.id, movie.id)
        end
      end
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
