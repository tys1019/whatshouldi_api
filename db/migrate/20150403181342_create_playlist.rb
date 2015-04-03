class CreatePlaylist < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.belongs_to :user, index: true
      t.string :name
      t.integer :list_type
    end
    add_foreign_key :playlists, :users
  end
end
