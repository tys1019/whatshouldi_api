class User < ActiveRecord::Base
  has_secure_password

  before_create :set_token
  after_create :make_playlist

  has_many :playlists, dependent: :destroy

  private
  def make_playlist
    playlist = Playlist.create(name: "My Queue", list_type: 0)
    self.playlists << playlist
  end

  def set_token
    return if token.present?
    self.token = generate_token
  end

  def generate_token
    SecureRandom.uuid.gsub(/\-/,'')
  end
end
