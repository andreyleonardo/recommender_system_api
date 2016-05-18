class MovieSerializer < ActiveModel::Serializer
  attributes :rank, :id, :title, :score, :rate

  has_many :genres
  has_many :describers
end
