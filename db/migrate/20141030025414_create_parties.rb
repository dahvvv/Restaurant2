class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.integer :table_number, null: false
      t.integer :guests, null: false
      t.boolean :paid, default: false

      t.timestamps
    end
  end
end
