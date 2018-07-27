class RemoveKeysFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :lyft_token
    remove_column :users, :lyft_refresh_token
    remove_column :users, :lyft_id
    add_column :users, :ride_count, :integer
  end
end
