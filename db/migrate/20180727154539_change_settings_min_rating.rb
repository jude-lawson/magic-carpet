class ChangeSettingsMinRating < ActiveRecord::Migration[5.2]
  def change
    remove_column :settings, :rating
  end
end
