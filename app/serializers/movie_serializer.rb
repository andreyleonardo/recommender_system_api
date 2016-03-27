class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :score
end
