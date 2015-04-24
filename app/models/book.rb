class Book < ActiveRecord::Base
  validates :google_id, uniqueness: true
  # has_many :saved_movies, dependent: :destroy
  # has_many :playlists, through: :saved_movies
end
