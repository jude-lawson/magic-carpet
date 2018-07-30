class AddMaxRatingToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :max_rating, :integer, :default => 5
  end
end
