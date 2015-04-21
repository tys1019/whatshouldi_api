class AddRelatedToShows < ActiveRecord::Migration
  def change
    add_column :shows, :related, :text
  end
end
