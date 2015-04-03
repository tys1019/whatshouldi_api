class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email
      t.string :username
      t.string :password_digest
      t.string :token

      t.timestamps null: false
    end
  end
end
