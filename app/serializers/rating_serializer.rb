class RatingSerializer < ActiveModel::Serializer
  attributes :rating, :id, :user_id

  has_one :movie
end
