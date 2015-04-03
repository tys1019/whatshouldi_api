class AddColumnsToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :guidebox_id, :integer
    add_column :movies, :artwork, :string
    add_column :movies, :rottentomatoes_id, :integer
    add_column :movies, :imdb_id, :string
    add_column :movies, :themoviedb_id, :integer
    add_column :movies, :trailer, :string
    add_column :movies, :purchase_web_sources, :text, array: true
    add_column :movies, :subscription_web_sources, :text, array: true
    add_column :movies, :other_sources, :text, array: true
    add_column :movies, :rt_ratings, :text, array: true
    add_column :movies, :rt_reviews, :text, array: true
    add_column :movies, :related, :text, array: true
  end
end
