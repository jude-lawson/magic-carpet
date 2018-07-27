class ChangeDefaultOfSetingsInUserTable < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :settings_id, :integer, :default=>0
  end
end
