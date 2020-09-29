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
        elsif input == "break out" 
            game = TextAdventure.new
            while game.over == 0
            game.start
            end
        elsif input == "3" || input =="exit"
            @over = 1
        end
    end

    def search_games
        puts "Input the name of the game you want to compare"
        search_string = gets.chomp
        puts "Searching the stars for a deal..."
        search_array = Game.return_all_games_with_n(search_string)
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
            puts "Please make a choice, or type back."
            results_array.each {|result| puts "#{result[0]}. #{result[1].name}"}
            input = gets.chomp
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
        puts "These games are heavily discounted at these stores!"
        #Insert Hector's methods here
    end
end
            

