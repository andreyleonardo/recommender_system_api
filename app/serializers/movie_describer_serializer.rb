class MovieDescriberSerializer < ActiveModel::Serializer
  attributes :id, :name

  def name
    object.describer.name
  end
end
