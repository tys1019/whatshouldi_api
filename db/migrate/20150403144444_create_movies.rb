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

      t.timestamps null: false
    end
  end
end
