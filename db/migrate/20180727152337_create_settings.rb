class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.integer :max_radius
      t.string :rating
      t.string :price
      t.integer :min_radius

      t.timestamps
    end
  end
end
