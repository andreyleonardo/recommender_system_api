# Predictor use 2 methods: similarities_for(:id) and find_predictions_for(item_set: [:ids])
# https://github.com/Pathgather/predictor
class MovieRecommender
  include Predictor::Base

  input_matrix :genres, weight: 5.0
  input_matrix :ratings, weight: 4.0
  input_matrix :rates, weight: 3.0
  input_matrix :users, weight: 2.0
  input_matrix :describers, weight: 1.0

  def add_movies_to_matrix
    Movie.find_each do |movie|
      if !movie.ratings.empty?
        total = 0.0
        movie.ratings.each { |x| total += x.rating }
        total /= movie.ratings.size
        add_to_matrix(:ratings, total.round, movie.id)
      else
        add_to_matrix(:ratings, 0, movie.id)
      end
      # unless movie.tags.empty?
      #   movie.tags.each do |tag|
      #     add_to_matrix(:tags, tag.tag, movie.id)
      #   end
      # end
      unless movie.genres.empty?
        movie.genres.each do |movie_genre|
          add_to_matrix(:genres, movie_genre.genre.id, movie.id)
        end
      end
      unless movie.describers.empty?
        movie.describers.each do |movie_describer|
          add_to_matrix(:genres, movie_describer.describer.id, movie.id)
        end
      end
      unless movie.rate.nil?
        if movie.rate == 'N/A'
          add_to_matrix(:rates, 'PG')
        else
          add_to_matrix(:rates, movie.rate)
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
