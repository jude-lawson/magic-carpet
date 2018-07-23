class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.integer :radius
      t.string :price_range
      t.string :rating
    end
  end
end
