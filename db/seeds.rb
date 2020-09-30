require 'faker'
require 'rest-client'
require 'json'
require 'pry'
query = []
count = 1
# Legacy Seed code. Very good way to check how good your internet connection is while also wating 20 minutes
# 600.times do
# response_string = RestClient.get("https://api.rawg.io/api/games?page=#{count}", headers = { "X-RapidAPI-Host" => "rawg-video-games-database.p.rapidapi.com",
# "X-RapidAPI-Key" => "a0fad62b23msh9f87cff95ae8856p1989eajsn8dfd7ce35f92"})
#   JSON.parse(response_string)["results"].each do |value|
#     query << value["name"]
#   end
#   count += 1
# end
# response_string = RestClient.get("https://api.rawg.io/api/games?search=zelda", headers = { "X-RapidAPI-Host" => "rawg-video-games-database.p.rapidapi.com", "X-RapidAPI-Key" => "a0fad62b23msh9f87cff95ae8856p1989eajsn8dfd7ce35f92"})
# results = JSON.parse(response_string)
# binding.pry
# #Fills out games table
#  query.each do |v|
#     msrp_array = [59.99,49.99,39.99,29.99,19.99]
#     v
#     Game.create(name: v, msrp: msrp_array[rand(msrp_array.length)])
#     end
#Fills out Store table
["GameStop","Target","Best Buy","WalMart"].each do |store|
    Store.create(name: store)
end
#more legacy. The App is more or less working without the need for seed data now.
# Store.all.each do |store|
#     Game.all.each do |game|
#         Listing.create(store_id: store.id, game_id: game.id, price: game.msrp - rand(5))
#     end
# end


