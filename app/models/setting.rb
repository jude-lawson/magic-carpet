class Setting < ApplicationRecord
  def price
    (min_price..max_price).to_a
  end
end
