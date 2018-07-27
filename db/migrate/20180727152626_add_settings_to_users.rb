class AddSettingsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :settings, foreign_key: true
  end
end
