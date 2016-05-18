class Describer < ActiveRecord::Base
  has_many :movies,
    class_name: 'MovieDescriber'

  validates :name, presence: true, uniqueness: true
end
