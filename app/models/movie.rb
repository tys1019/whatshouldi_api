class Movie < ActiveRecord::Base
  has_many :saved_movies, dependent: :destroy
end
