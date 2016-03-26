class Movie < ActiveRecord::Base  
  has_many :tags
  has_many :ratings
end
