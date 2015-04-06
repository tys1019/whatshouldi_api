class Playlist < ActiveRecord::Base
  enum status: [:main_collection, :custom_playlist]


  belongs_to :user
  has_many :saved_movies, dependent: :destroy
  has_many :movies, through: :saved_movies

  def add_remove_item(item)
    @movie = Movie.find(item['id'])
    if self.movies.where(id: @movie.id) == []
      self.movies << @movie
    else
      self.movies.delete(@movie)
    end
  end
end
