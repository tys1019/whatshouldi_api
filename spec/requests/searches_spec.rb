require 'rails_helper'

RSpec.describe "Searches", :type => :request do

  # describe "GET /search" do
  #   it "searches for a movie by title" do
  #     post "/search",
  #     {
  #       media_type: "movie",
  #       search_query: "fight club"
  #     }
  #     expect(response).to have_http_status(200)

  #     json = JSON.parse(response.body)
  #     expect(json['response']['results'][0]['title']).to eq "Fight Club"
  #   end
  # end

  describe "GET /search" do

      let(:valid_attributes) {
        ({
          title: "Fight Club",
          genres: ["action", "adventure"],
          overview: "Men fight about stuff.",
          guidebox_id: 12917
          })
      }

    it "finds movie by guidebox_id in the database" do
      movie = Movie.create! valid_attributes
      post "/search",
      {
        media_type: "movie",
        guidebox_id: 12917
      }
      expect(response).to have_http_status(200)

      require 'byebug'
      binding.pry

      movie = JSON.parse(response.body)['movie']
      expect(movie['title']).to eq "Fight Club"
    end

    it "searches for a movie by guidebox id" do
      post "/search",
      {
        media_type: "movie",
        guidebox_id: 12917
      }
      expect(response).to have_http_status(200)

      movie = JSON.parse(response.body)['movie']
      expect(movie['title']).to eq "Fight Club"
    end
  end
end
