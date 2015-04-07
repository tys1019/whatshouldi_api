class Movie < ActiveRecord::Base
  has_many :saved_movies, dependent: :destroy
  has_many :playlists, through: :saved_movies
end
