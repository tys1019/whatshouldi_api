require "rails_helper"

RSpec.describe SearchesController, :type => :routing do
  describe "routing" do

    it "routes to #search" do
      expect(:post => "/search").to route_to("searches#search")
    end
  end
end
