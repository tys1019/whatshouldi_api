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
    @movie = Movie.find_by(guidebox_id: @search_params[:guidebox_id])

    # saves movie to database to speed up queries
    if !@movie
      uri = URI(ENV['GUIDEBOX_BASE_URL'] + "/movie/" + @search_params[:guidebox_id])
      response = JSON.parse(Net::HTTP.get(uri))

      @movie = Movie.create(
        title: response['title'],
        overview: response['overview'],
        poster_path: response['poster_400x570'],
        runtime: response['duration'] / 60,
        guidebox_id: response['id'],
        rottentomatoes_id: response['rottentomatoes'],
        imdb_id: response['imdb'],
        themoviedb_id: response['themoviedb'],
        trailer: response['trailers']['web'][0]['embed'],
        purchase_web_sources: response['purchase_web_sources'],
        subscription_web_sources: response['subscription_web_sources'],
        other_sources: response['other_sources'],
        )
    end
  end

  def tv_title_search
    1
  end
end


