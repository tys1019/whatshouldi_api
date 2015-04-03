require 'rails_helper'

RSpec.describe "Searches", :type => :request do

  describe "GET /search" do
    it "searches for a movie by title" do
      post "/search",
      {
        media_type: "movie",
        search_query: "fight club"
      }
      expect(response).to have_http_status(200)


      require 'byebug'
      binding.pry

      json = JSON.parse(response.body)
      expect(json['response']['results'][0]['title']).to eq "Fight Club"
    end
  end

  describe "GET /search" do
    it "searches for a movie by guidebox id" do
      post "/search",
      {
        media_type: "movie",
        guidebox_id: 12917
      }
      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)
      expect(json['response']['title']).to eq "Fight Club"
    end
  end
end
