

class SearchesController < ApplicationController

  def search
    @search = Search.new(search_params)

    render json: @search, status: 200
  end


  private


    def search_params
      params.permit(:media_type, :search_query, :guidebox_id)
    end
end


# curl -H "Content-Type: application/json" -X POST -d '{"media_type": "movie","guidebox_id": 12917}' http://localhost:3000/search
