class AddToKitchenToFoods < ActiveRecord::Migration
  def change
    add_column :foods, :to_kitchen, :boolean
  end
end
