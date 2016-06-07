class Movie < ActiveRecord::Base
  has_many :tags
  has_many :ratings
  has_many :genres,
    class_name: 'MovieGenre'
  has_many :describers,
    class_name: 'MovieDescriber'
  has_one :link
  has_many :ratings

  attr_accessor :score, :rank

  def self.update_info_from_api(run_recommender)
    RecoveryMovieInfoWorker.perform_async run_recommender
  end

  def delete_describers
    recommender = MovieRecommender.new
    recommender.delete_describers_from_matrix(id)
    describers.delete_all
  end
end
