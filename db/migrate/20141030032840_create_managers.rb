class CreateManagers < ActiveRecord::Migration
  def change
    create_table :managers do |t|
      t.string :username, null: false
      t.string :password_hash, null: false
      t.string :avatar_url

      t.timestamps
    end
  end
end
