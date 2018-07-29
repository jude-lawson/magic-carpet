class RemoveSettingId < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :settings_id
  end
end
