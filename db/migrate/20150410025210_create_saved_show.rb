class CreateSavedShow < ActiveRecord::Migration
  def change
    create_table :saved_shows do |t|
      t.belongs_to :playlist, index: true
      t.belongs_to :show, index: true
    end
    add_foreign_key :saved_shows, :playlists
    add_foreign_key :saved_shows, :shows
  end
end
