class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name, null: false
      t.string :cuisine_type
      t.integer :cents, null: false
      t.string :allergens
      t.string :img_url

      t.timestamps
    end
  end
end
