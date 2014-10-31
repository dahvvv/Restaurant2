class Order < ActiveRecord::Base
  belongs_to(:party)
  belongs_to(:food)

  def charge
    food = Food.where(:id => self.food_id)[0]
    if self.no_charge == true
      0
    else
      food.price_from_db
    end
  end

  def food_name
    Food.where(:id => self.food_id)[0].name
  end

  # def self.list_for_chef
  #   self.where(:ready => false).order(id: :desc)
  # end

  def self.list_for_chef
    list = []
    draft_list = self.where(:ready => false).order(id: :desc)
    draft_list.each do |order|
      if order.food.to_kitchen == true
        list << order
      end
    end
    list
  end

end

# , self.food.to_kitchen: true}
# kitchen_foods = Food.where(:to_kitchen => true)
# kitchen_foods
