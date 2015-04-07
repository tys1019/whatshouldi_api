require 'net/http'

class Search
  attr_accessor :results

  def initialize(search_params)
    @search_params = search_params

    if @search_params[:search_type]
      if @search_params[:search_type] == "rt_ratings"
        @results = rottentomatoes_ratings
      elsif @search_params[:search_type] == "rt_reviews"
        @results = rottentomatoes_reviews
      else
        @results = []
      end

    elsif @search_params[:guidebox_id]
      @results = movie_details

    elsif @search_params[:media_type] == "Movie"
      @results = movie_title_search

    end

    # else @search_params[:media_type] == "TV"
    #   tv_title_search


    @results
  end

  def movie_title_search
    query = @search_params[:search_query].gsub(/\s/, '%2520')
    uri = URI(ENV['GUIDEBOX_BASE_URL'] + "/search/movie/title/" + query)
    response = JSON.parse(Net::HTTP.get(uri))
    response['results']
  end

  def movie_details
    @movie = Movie.find_by(guidebox_id: @search_params[:guidebox_id])

    # saves movie to database to speed up queries
    if !@movie
      uri = URI(ENV['GUIDEBOX_BASE_URL'] + "/movie/" + @search_params[:guidebox_id])
      response = JSON.parse(Net::HTTP.get(uri))

      @movie = Movie.new(title: response['title'])
      @movie.overview = response['overview']
      @movie.poster_path = response['poster_400x570']
      @movie.thumbnail = response['poster_240x342']
      @movie.runtime = response['duration'] / 60
      @movie.guidebox_id = response['id']
      @movie.rottentomatoes_id = response['rottentomatoes']
      @movie.imdb_id = response['imdb']
      @movie.themoviedb_id = response['themoviedb']
      @movie.trailer = response['trailers']['web'][0]['embed'] if !!response['trailers']['web'][0]
      @movie.cast = response['cast']
      @movie.free_web_sources = response['free_web_sources']
      @movie.purchase_web_sources = response['purchase_web_sources']
      @movie.subscription_web_sources = response['subscription_web_sources']
      @movie.save
    end
  end

  def rottentomatoes_ratings
    @movie = Movie.find_by(rottentomatoes_id: @search_params[:rottentomatoes_id])

    uri = URI(ENV['ROTTENTOMATOES_BASE_URL']  + @movie.rottentomatoes_id.to_s + '.json?apikey=' + ENV['ROTTENTOMATOES_KEY'])
    response = JSON.parse(Net::HTTP.get(uri))

    @movie.overview = response['synopsis']
    @movie.genres = response['genres']
    @movie.rt_ratings = response['ratings']
    @movie.save
  end

  def rottentomatoes_reviews
    @movie = Movie.find_by(rottentomatoes_id: @search_params[:rottentomatoes_id])

    uri = URI(ENV['ROTTENTOMATOES_BASE_URL']  + @movie.rottentomatoes_id.to_s + '/reviews.json?review_type=top_critic&page_limit=20&page=1&country=us&apikey=' + ENV['ROTTENTOMATOES_KEY'])
    response = JSON.parse(Net::HTTP.get(uri))

    @movie.rt_reviews = response['reviews']
    @movie.save
  end

  def tv_title_search
    1
  end
end


