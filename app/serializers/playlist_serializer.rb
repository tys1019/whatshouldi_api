class PlaylistSerializer < ActiveModel::Serializer
  attributes :id, :list_type
  has_many :movies
end
