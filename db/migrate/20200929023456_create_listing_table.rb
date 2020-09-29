class CreateListingTable < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.belongs_to :game
      t.belongs_to :store
      t.float :price
    end
  end
end
