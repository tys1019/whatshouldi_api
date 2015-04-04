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

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Movie" do
        expect {
          post :create, {:movie => valid_attributes}
        }.to change(Movie, :count).by(1)
      end

      it "assigns a newly created movie as @movie" do
        post :create, {:movie => valid_attributes}
        expect(assigns(:movie)).to be_a(Movie)
        expect(assigns(:movie)).to be_persisted
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        ({
          tagline: "First rule of fight club...",
          runtime: 139
          })
      }

      it "updates the requested movie" do
        movie = Movie.create! valid_attributes
        put :update, {:id => movie.to_param, :movie => new_attributes}
        movie.reload

        expect(movie.runtime).to eq(139)

      end

      it "assigns the requested movie as @movie" do
        movie = Movie.create! valid_attributes
        put :update, {:id => movie.to_param, :movie => valid_attributes}
        expect(assigns(:movie)).to eq(movie)
      end
    end
  end
end
