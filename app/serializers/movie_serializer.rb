class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :genres
end
