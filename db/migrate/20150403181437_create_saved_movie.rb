class CreateSavedMovie < ActiveRecord::Migration
  def change
    create_table :saved_movies do |t|
      t.belongs_to :playlist, index: true
      t.belongs_to :movie, index: true
    end
    add_foreign_key :saved_movies, :playlists
    add_foreign_key :saved_movies, :movies
  end
end
