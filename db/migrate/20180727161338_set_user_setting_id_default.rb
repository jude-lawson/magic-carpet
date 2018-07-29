class SetUserSettingIdDefault < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :setting_id, :bigint, :default=>0
  end
end
