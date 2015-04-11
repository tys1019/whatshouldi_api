class ChangeDataTypeForRelated < ActiveRecord::Migration
  def change
    change_table :movies do |t|
      t.change :related, :text
    end
  end
end

