class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :first_name, :last_name, :email, :token, :created_at, :updated_at, :playlist_id

  def playlist_id
     @object.playlists.first.id
  end
end
