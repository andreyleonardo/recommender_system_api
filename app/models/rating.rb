class Rating < ActiveRecord::Base
  belongs_to :movie

  has_and_belongs_to_many :users,
    join_table: 'user_ratings'
end
