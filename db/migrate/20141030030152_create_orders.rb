class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :food
      t.references :party
      t.boolean :no_charge, default: false
      t.boolean :ready, default: false
      t.boolean :delivered, default: false

      t.timestamps
    end
  end
end
