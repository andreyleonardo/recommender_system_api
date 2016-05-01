class MovieDescriber < ActiveRecord::Base
  belongs_to :movie
  belongs_to :describer
end
