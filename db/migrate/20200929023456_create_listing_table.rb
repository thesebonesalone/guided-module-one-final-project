class CreateListingTable < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.integer :game_id
      t.integer :store_id
      t.float :price
    end
  end
end
