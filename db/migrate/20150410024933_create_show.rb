class CreateShow < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :title
      t.text :overview
      t.string :poster_path
      t.integer :runtime
      t.integer :guidebox_id
      t.string :artwork
      t.integer :rottentomatoes_id
      t.string :imdb_id
      t.integer :themoviedb_id
      t.text :cast, array: true
      t.text :purchase_web_sources
      t.text :free_web_sources
      t.text :subscription_web_sources
      t.text :episodes
      t.text :seasons
    end
  end
end
