class AddMinRatingToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :min_rating, :integer, :default => 1
  end
end
