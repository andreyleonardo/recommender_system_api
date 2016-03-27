class MovieGenreSerializer < ActiveModel::Serializer
  attributes :name

  def name
    object.genre.name
  end
end
