class AddSettingReferenceToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :setting
  end
end
