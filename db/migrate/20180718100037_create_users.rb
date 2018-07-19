class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :lyft_id
      t.string :first_name
      t.string :last_name
      t.string :lyft_token
      t.string :lyft_refresh_token

      t.timestamps
    end
  end
end
