class Show < ActiveRecord::Base
  has_many :saved_shows, dependent: :destroy
  has_many :playlists, through: :saved_shows
end
