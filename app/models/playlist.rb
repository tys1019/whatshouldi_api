class Playlist < ActiveRecord::Base
  enum status: [:main_collection, :custom_playlist]


  belongs_to :user
  has_many :saved_movies, dependent: :destroy
  has_many :movies, through: :saved_movies
end
