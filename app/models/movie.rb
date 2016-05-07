class Movie < ActiveRecord::Base
  has_many :tags
  has_many :ratings
  has_many :genres,
    class_name: 'MovieGenre'
  has_many :describers,
    class_name: 'MovieDescriber'
  has_one :link

  attr_accessor :score

  def self.update_info_from_api(run_recommender)
    RecoveryMovieInfoWorker.perform_async run_recommender
  end
end
