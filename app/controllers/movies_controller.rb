class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :update]

  # GET /movies
  # GET /movies.json
  def index

    @movies = Movie.all.sample(18)
    render json: @movies, serialier: MovieIndexSerializer
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    render json: @movie
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      render json: @movie, status: :created, location: @movie
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  def update
    if @movie.update(movie_params)
      head :no_content
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end


  private

    def set_movie
      @movie = Movie.find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(:genres, :title, :overview, :poster_path, :runtime, :tagline, :tmdb_vote_average, :guidebox_id, :artwork, :rottentomatoes_id, :imdb_id, :themoviedb_id, :trailer, :purchase_web_sources , :subscription_web_sources, :other_sources, :rt_ratings, :rt_reviews , :related)
    end
end
