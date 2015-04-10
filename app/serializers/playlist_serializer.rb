class PlaylistSerializer < ActiveModel::Serializer
  attributes :id, :list_type, :shows_simple
  has_many :movies
  # has_many :shows

  def shows_simple
     @object.shows.map do |show|

      show['seasons'] = nil
      show
     end
  end

end
