class ShowsController < ApplicationController
  before_action :set_movie, only: [:show, :update]

  # GET /shows
  # GET /shows.json
  def index

    @shows = Show.all.sample(4)
    render json: @shows
  end

  # GET /shows/1
  # GET /shows/1.json
  def show
    render json: @show
  end

  # POST /shows
  # POST /shows.json
  def create
    @show = Show.new(show_params)

    if @show.save
      render json: @show, status: :created, location: @show
    else
      render json: @show.errors, status: :unprocessable_entity
    end
  end

  def update
    if @show.update(show_params)
      head :no_content
    else
      render json: @show.errors, status: :unprocessable_entity
    end
  end


  private

    def set_show
      @show = Show.find(params[:id])
    end

    def show_params
      params.require(:show).permit( :title, :overview, :poster_path, :runtime, :guidebox_id, :artwork, :rottentomatoes_id, :imdb_id, :themoviedb_id, :cast, :purchase_web_sources, :free_web_sources, :subscription_web_sources)
    end
end
