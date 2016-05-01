class Describer < ActiveRecord::Base
  has_many :movies,
    class_name: 'MovieDescriber'
end
