class Party < ActiveRecord::Base
  has_many(:orders)
  has_many(:foods, :through => :orders)

  def food_names_for_receipt
    self.orders.map do |order|
      order.food_name.gsub(" ", "_").to_sym
    end
  end

  def prices_for_receipt
    self.orders.map do |order|
      order.charge.to_f
    end
  end

  def total
    total = 0
    self.orders.each do |order|
      total += order.food.cents if order.no_charge == false
    end
    if total < 10
      "$0.0" + total.to_s
    elsif total < 100
      "$0." + total.to_s
    else
      "$" + total.to_s[0..-3] + "." + total.to_s[-2..-1]
    end
  end

  def self.from_table(table_num)
    self.find_by(table_number: table_num)
  end

  def self.status(table_num)
    if self.from_table(table_num) == nil
      "grey"
    else
      party = self.from_table(table_num)
      if party.paid == true
        "green"
      elsif party.orders.where(ready: true) != party.orders.where(delivered: true)
        "red"
      else
        "blue"
      end
    end

  end

end