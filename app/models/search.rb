require 'net/http'

class Search

  def initialize(search_params)
    @search_params = search_params
    if @search_params[:media_type] == "movie"

      if @search_params[:guidebox_id]
        @response = movie_details
      else
        @response = movie_title_search
      end

    else @search_params[:media_type] == "tv"
      @response = tv_title_search
    end

    @response
  end

  def movie_title_search
    query = @search_params[:search_query].gsub(/\s/, '%2520')
    uri = URI(ENV['GUIDEBOX_BASE_URL'] + "/search/movie/title/" + query)
    response = JSON.parse(Net::HTTP.get(uri))
  end

  def movie_details
    uri = URI(ENV['GUIDEBOX_BASE_URL'] + "/movie/" + @search_params[:guidebox_id])
    response = JSON.parse(Net::HTTP.get(uri))
  end

  def tv_title_search
    1
  end
end


