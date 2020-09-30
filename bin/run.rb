require_relative '../config/environment.rb'
require 'rest-client'
require 'json'
require "faker"
require "pry"
system "clear"


run = Interact.new
while run.over == 0 do
    while run.user == nil
        run.login
    end
    run.options

end
exit




# response_string = RestClient.get('https://rawg-video-games-database.p.rapidapi.com/games', headers = { "X-RapidAPI-Host" => "rawg-video-games-database.p.rapidapi.com",
# "X-RapidAPI-Key" => "a0fad62b23msh9f87cff95ae8856p1989eajsn8dfd7ce35f92"})
#   query = JSON.parse(response_string)

#   binding.pry
