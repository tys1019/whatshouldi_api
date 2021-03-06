

class SearchesController < ApplicationController

  def search
    @search = Search.new(search_params)


    render json: @search, status: 200
  end


  private


    def search_params
      params.permit(:media_type, :search_query, :guidebox_id, :imdb_id, :rottentomatoes_id, :search_type, :season)
    end
end

