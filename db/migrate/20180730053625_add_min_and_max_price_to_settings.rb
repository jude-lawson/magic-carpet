class AddMinAndMaxPriceToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :max_price, :integer, :default => 4
    add_column :settings, :min_price, :integer, :default => 1
    remove_column :settings, :price
  end
end
