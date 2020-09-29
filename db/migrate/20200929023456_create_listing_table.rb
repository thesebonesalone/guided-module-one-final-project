class CreateListingTable < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.belongs_to :game
      t.belongs_to :store
      t.float :price
    end
  end
end


# top_ten = Listing.all.sort_by do |listing|
#   listing.price / listing.game.msrp
# end
# count = 0
# 10.times do
#   game = top_ten[count].game
#   puts "#{game.name} is discounted at #{top_ten[0].price / game.msrp}% off at #{top_ten[0].store.name} for a total of #{top_ten[0].price}"
#   count += 1
# end