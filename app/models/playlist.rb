class Playlist < ActiveRecord::Base
  enum status: [:main_collection, :custom_playlist]


  belongs_to :user
  has_many :saved_movies, dependent: :destroy
  has_many :movies, through: :saved_movies

  has_many :saved_shows, dependent: :destroy
  has_many :shows, through: :saved_shows


  def add_remove_item(params)
    if params.key?('movie')
      @movie = Movie.find(params['movie']['id'])
      if self.movies.where(id: @movie.id) == []
        self.movies << @movie
      else
        self.movies.delete(@movie)
      end
    else
      @show = Show.find(params['show']['id'])
      if self.shows.where(id: @show.id) == []
        self.shows << @show
      else
        self.shows.delete(@show)
      end
    end
  end

end
