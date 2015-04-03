require 'rails_helper'

RSpec.describe "Movies", :type => :request do


  before(:all) do
    Movie.destroy_all
    @movies = FactoryGirl.create_list(:movie, 25)
  end

  describe "GET /movies" do
    it "gets all movies" do
      get movies_path
      expect(response).to have_http_status(200)
      movies = JSON.parse(response.body)
      expect(movies.length).to eq 25
    end
  end
end
