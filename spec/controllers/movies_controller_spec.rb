require 'rails_helper'


RSpec.describe MoviesController, :type => :controller do


  let(:valid_attributes) {
    ({
      title: "Fight Club",
      genres: ["action", "adventure"],
      overview: "Men fight about stuff."
      })
  }


  describe "GET index" do
    it "assigns all movies as @movies" do
      movie = Movie.create! valid_attributes
      get :index, {}
      expect(assigns(:movies)).to eq([movie])
    end
  end

  describe "GET show" do
    it "assigns the requested movie as @movie" do
      movie = Movie.create! valid_attributes
      get :show, {:id => movie.to_param}
      expect(assigns(:movie)).to eq(movie)
    end
  end

  # describe "POST create" do
  #   describe "with valid params" do
  #     it "creates a new Movie" do
  #       expect {
  #         post :create, {:movie => valid_attributes}, valid_session
  #       }.to change(Movie, :count).by(1)
  #     end

  #     it "assigns a newly created movie as @movie" do
  #       post :create, {:movie => valid_attributes}, valid_session
  #       expect(assigns(:movie)).to be_a(Movie)
  #       expect(assigns(:movie)).to be_persisted
  #     end

  #     it "redirects to the created movie" do
  #       post :create, {:movie => valid_attributes}, valid_session
  #       expect(response).to redirect_to(Movie.last)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns a newly created but unsaved movie as @movie" do
  #       post :create, {:movie => invalid_attributes}, valid_session
  #       expect(assigns(:movie)).to be_a_new(Movie)
  #     end

  #     it "re-renders the 'new' template" do
  #       post :create, {:movie => invalid_attributes}, valid_session
  #       expect(response).to render_template("new")
  #     end
  #   end
  # end
end
