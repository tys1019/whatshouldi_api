class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :google_id
      t.string :thumbnail
      t.string :title
    end
  end
end
