class ChangeDataTypeForRtRatings < ActiveRecord::Migration
  def change
    change_table :movies do |t|
      t.change :rt_ratings, :text
    end
  end
end
