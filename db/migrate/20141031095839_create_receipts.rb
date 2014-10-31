class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.integer :table_number
      t.string :food_list
      t.string :price_list
      t.string :total

      t.timestamps
    end
  end
end
