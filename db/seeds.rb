require 'faker'
#Fills out games table
100.times do |v|
    msrp_array = [59.99,49.99,39.99,29.99,19.99]
    Game.create(name: Faker::Game.title, msrp: msrp_array[rand(msrp_array.length)])
end
#Fills out Store table
["GameStop","Target","Best Buy","WalMart"].each do |store|
    Store.create(name: store)
end
Store.all.each do |store|
    Game.all.each do |game|
        Listing.create(store_id: store.id, game_id: game.id, price: game.msrp - rand(5))
    end
end
