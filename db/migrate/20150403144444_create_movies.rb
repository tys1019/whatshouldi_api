class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.text :genres, array: true
      t.string :title
      t.text :overview
      t.string :poster_path
      t.integer :runtime
      t.string :tagline
      t.string :tmdb_vote_average
      t.integer :guidebox_id
      t.string :artwork
      t.integer :rottentomatoes_id
      t.string :imdb_id
      t.integer :themoviedb_id
      t.string :trailer
      t.text :purchase_web_sources, array: true
      t.text :subscription_web_sources, array: true
      t.text :other_sources, array: true
      t.text :rt_ratings, array: true
      t.text :rt_reviews, array: true
      t.text :related, array: true

      t.timestamps null: false
    end
  end
end
