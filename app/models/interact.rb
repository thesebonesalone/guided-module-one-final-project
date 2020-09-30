class Interact
    attr_accessor :over
    def initialize
        @over = 0
        system "clear"
    end


    def options
        puts "Please choose an option:"
        puts "1. Search Games"
        puts "2. See Deals"
        puts "3. Exit"

        input = gets.chomp
        input = input.downcase
        if input == "1"
            self.search_games
        elsif input == "2"
            self.see_deals
        elsif input == "goose adventure super deluxe" 
            game = TextAdventure.new
            while game.over == 0
            game.start
            end
        elsif input == "3" || input =="exit"
            @over = 1
        end
    end

    def search_database_by_name(name)
        response_string = RestClient.get("https://api.rawg.io/api/games?search=#{name}", headers = { "X-RapidAPI-Host" => "rawg-video-games-database.p.rapidapi.com", "X-RapidAPI-Key" => "a0fad62b23msh9f87cff95ae8856p1989eajsn8dfd7ce35f92"})
        results = JSON.parse(response_string)["results"]

        #binding.pry
        results_array = results.map {|v| v["name"]}
        return_array = []
        results_array.each do |value|
            msrp_array = [19.99,25.99,29.99,39.99,49.99,59.99]
            game = Game.where(:name => value).first_or_create(:msrp => msrp_array[rand(msrp_array.length)])
            return_array << game
            Store.all.each do |store|
                store.listings.where(:game_id => game.id).first_or_create(:game_id => game.id, :store_id => store.id, :price => game.msrp - rand(10))
            end
        end
        return_array
        
    end




    def search_games
        puts "Input the name of the game you want to compare"
        search_string = gets.chomp
        puts "Searching the stars for a deal..."
        search_array = search_database_by_name(search_string)







        #search_array = Game.return_all_games_with_n(search_string)
        results_array = []
        count = 1
        #builds an array that can be used via numeric selection
        search_array.each do |game|
            results_array << [count, game]
            count += 1
        end
        #prompts player for their choice via numeric selection
        choice = -1
        while choice == -1 do
            system "clear"
            puts "Please make a choice, or type back."
            results_array.each {|result| puts "#{result[0]}. #{result[1].name}"}
            if results_array == []
                puts "Nothing here but us Chickens."
                return nil
            end
            input = gets.chomp
            system "clear"
            if input == "back"
                choice = -2
            elsif input.to_i != 0
                choice = input.to_i
            end
            if choice > 0 and choice <= results_array[-1][0]
                puts "Searching listings..."
                game = results_array[choice - 1][1]
            else
                puts "Please make a valid choice."
                choice = -1
            end
        end
        game.parse_listings.each {|value| puts value}
        #Insert Hector's methods here
    end
    def see_deals
        system "clear"
        puts "These games are heavily discounted at these stores!"
        Game.returns_top_10_discounted_games
    end
end
            

