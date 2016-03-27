class Movie < ActiveRecord::Base
  has_many :tags
  has_many :ratings
  has_many :genres,
    class_name: 'MovieGenre'

  attr_accessor :score
end
