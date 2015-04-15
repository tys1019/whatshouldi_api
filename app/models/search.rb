require 'net/http'
require 'rest_client'


class Search
  attr_accessor :results

  def initialize(search_params)
    @search_params = search_params

    if @search_params[:search_type]
      if @search_params[:search_type] == "rt_ratings"
        @results = rottentomatoes_ratings
      elsif @search_params[:search_type] == "rt_reviews"
        @results = rottentomatoes_reviews
      elsif @search_params[:search_type] == "seasons"
        @results = get_seasons
      elsif @search_params[:search_type] == "episodes"
        @results = get_episodes
      elsif @search_params[:search_type] == "related_movies"
        @results = get_related_movies
      elsif @search_params[:search_type] == "related_shows"
        @results = get_related_shows
      else
        @results = []
      end

    elsif @search_params[:guidebox_id] || @search_params[:imdb_id]
      if @search_params[:media_type] == "Movie"
         @results = movie_details
      elsif @search_params[:media_type] == "TV"
        @results = tv_details
      end

    elsif @search_params[:media_type]
      @search_params[:media_type] = @search_params[:media_type].strip
      if @search_params[:media_type] == "Movie"
        @results = movie_title_search
      elsif @search_params[:media_type] == "TV"
        @results = tv_title_search
      end
    end

    @results
  end

  def movie_title_search
    query = @search_params[:search_query].gsub(/\s/, '%2520')
    uri = URI(ENV['GUIDEBOX_BASE_URL'] + "/search/movie/title/" + query)
    response = JSON.parse(Net::HTTP.get(uri))
    response['results']
  end

  def movie_details
    if @search_params[:guidebox_id]
      @movie = Movie.find_by(guidebox_id: @search_params[:guidebox_id])
    elsif @search_params[:imdb_id]
      @movie = Movie.find_by(imdb_id: @search_params[:imdb_id])
    else
    end

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
      @movie.trailer = response['trailers']['web'][0]['link'] if !!response['trailers']['web'][0]
      # @movie.cast = response['cast'].to_json
      @movie.purchase_web_sources = shorten_link_data(response['purchase_web_sources'])
      @movie.free_web_sources = shorten_link_data(response['free_web_sources'])
      @movie.subscription_web_sources = shorten_link_data(response['subscription_web_sources'])
      @movie.save
    end
  end

  def get_related_movies
    @movie = Movie.find_by(imdb_id: @search_params[:imdb_id])

    headers = {
      :content_type => 'application/json',
      :trakt_api_version => '2',
      :trakt_api_key => ENV['TRAKT_CLIENT_ID']
    }
    response = RestClient::Request.execute(:url => 'https://api-v2launch.trakt.tv/movies/' + @movie.imdb_id + '/related', :method => :get, :verify_ssl => false, :headers => headers)

    @movie.related = response
    @movie.save
    response
  end

  def get_related_artwork(related_array)

  end

  def get_related_shows

  end

  def rottentomatoes_ratings
    @movie = Movie.find_by(rottentomatoes_id: @search_params[:rottentomatoes_id])

    uri = URI(ENV['ROTTENTOMATOES_BASE_URL']  + @movie.rottentomatoes_id.to_s + '.json?apikey=' + ENV['ROTTENTOMATOES_KEY'])
    response = JSON.parse(Net::HTTP.get(uri))

    @movie.genres = response['genres']
    @movie.rt_ratings = response['ratings'].to_json
    @movie.save
  end

  def rottentomatoes_reviews
    @movie = Movie.find_by(rottentomatoes_id: @search_params[:rottentomatoes_id])

    uri = URI(ENV['ROTTENTOMATOES_BASE_URL']  + @movie.rottentomatoes_id.to_s + '/reviews.json?review_type=top_critic&page_limit=20&page=1&country=us&apikey=' + ENV['ROTTENTOMATOES_KEY'])
    response = JSON.parse(Net::HTTP.get(uri))

    @movie.rt_reviews = response['reviews'].to_json
    @movie.save
  end

  def shorten_link_data(links_array)
    smaller = links_array.map do |source|
      source.delete('formats')
      source
    end
    smaller.to_json
  end

  def tv_title_search
    query = @search_params[:search_query].gsub(/\s/, '%2520')
    uri = URI(ENV['GUIDEBOX_BASE_URL'] + "/search/title/" + query)
    response = JSON.parse(Net::HTTP.get(uri))
    response['results']
  end

  def tv_details
    @show = Show.find_by(guidebox_id: @search_params[:guidebox_id])

    if !@show
      uri = URI(ENV['GUIDEBOX_BASE_URL'] + "/show/" + @search_params[:guidebox_id])
      response = JSON.parse(Net::HTTP.get(uri))


      @show = Show.new(title: response['title'])

      @show.artwork = response['artwork_448x252']
      @show.overview = response['overview']
      @show.poster_path = response['poster']
      @show.runtime = response['runtime']
      @show.guidebox_id = response['id']
      @show.imdb_id = response['imdb_id']
      @show.themoviedb_id = response['themoviedb']
      @show.save
    end
    @show
  end

  def get_episodes
    @show = Show.find_by(guidebox_id: @search_params[:guidebox_id])

    uri = URI(ENV['GUIDEBOX_BASE_URL'] + "/show/" + @search_params[:guidebox_id].to_s + "/episodes/" + @search_params[:season].to_s + "/0/25/all/web/true")

    response = JSON.parse(Net::HTTP.get(uri))

    response['results'].each do |episode|
      episode['purchase_web_sources'] = shorten_link_data(episode['purchase_web_sources'])
      episode['free_web_sources'] = shorten_link_data(episode['free_web_sources'])
      episode['subscription_web_sources'] = shorten_link_data(episode['subscription_web_sources'])
      episode['tv_everywhere_web_sources'] = shorten_link_data(episode['tv_everywhere_web_sources'])
    end

    response['results'].to_json
  end

  def get_seasons
    @show = Show.find_by(guidebox_id: @search_params[:guidebox_id])
    uri = URI(ENV['GUIDEBOX_BASE_URL'] + "/show/" + @search_params[:guidebox_id].to_s + "/seasons")
    response = JSON.parse(Net::HTTP.get(uri))
    @show.seasons = response['results'].to_json
    @show.save
    @show.seasons
  end


end


