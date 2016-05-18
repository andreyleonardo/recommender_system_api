class Rating < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  def self.find_best_ratings_by_user_id(user_id)
    rating_avg = Rating.average(:rating).to_f.round(1)
    where('user_id = ? AND rating >= ?', user_id, rating_avg).order(rating: :desc)
  end

  def self.delete_movie_ratings(movie_id)
    where(movie_id: movie_id).delete_all
  end
end
