class AddDefaultRideCountToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :ride_count, :integer, :default=>0
  end
end
