class Food < ActiveRecord::Base
  has_many(:orders)
  has_many(:parties, :through => :orders)

  def price_from_db
    if self.cents < 10
      "0.0" + self.cents.to_s
    elsif self.cents < 100
      "0." + self.cents.to_s
    else
      self.cents.to_s[0..-3] + "." + self.cents.to_s[-2..-1]
    end
  end
end