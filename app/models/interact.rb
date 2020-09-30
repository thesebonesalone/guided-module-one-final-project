class Interact
    attr_accessor :over, :user
    def initialize
        @user = nil
        @over = 0
        system "clear"
        puts <<-STR
        ooooooooo.             o8o                          
        `888   `Y88.           `"'                          
         888   .d88' oooo d8b oooo   .ooooo.   .ooooo.      
         888ooo88P'  `888""8P `888  d88' `"Y8 d88' `88b     
         888          888      888  888       888ooo888     
         888          888      888  888   .o8 888    .o     
        o888o        d888b    o888o `Y8bod8P' `Y8bod8P'
        
        STR
        sleep(0.5)                                                    
        puts <<-STR                                                    
                                                            
                       ooo        ooooo oooooo   oooo       
                       `88.       .888'  `888.   .8'        
                        888b     d'888    `888. .8'         
                        8 Y88. .P  888     `888.8'          
                        8  `888'   888      `888'           
                        8    Y     888       888            
                       o8o        o888o     o888o           
        
                       STR
        sleep(0.5)
        puts <<-STR
                       
                                                            
                                                            
          .oooooo.                                          
         d8P'  `Y8b                                         
        888            .oooo.   ooo. .oo.  .oo.    .ooooo.  
        888           `P  )88b  `888P"Y88bP"Y88b  d88' `88b 
        888     ooooo  .oP"888   888   888   888  888ooo888 
        `88.    .88'  d8(  888   888   888   888  888    .o 
         `Y8bood8P'   `Y888""8o o888o o888o o888o `Y8bod8P'


         STR
         sleep(0.5)
         puts "paste https://www.youtube.com/watch?v=FwYlSW1yIlk in your browser for fanfare"
    end
    
    def login
        puts "Please choose an option:"
        puts "1. Login"
        puts "2. Create New User"
        puts "3. Exit"
        input = gets.chomp
        if input == "3" || input == "exit"
            exit
        elsif input == "1"
            if User.all != []
                while @user == nil
                    self.get_login
                end
            else
                puts "There are no users, please create one!"
            end
        elsif input == "2"
            self.create_new_user_and_password
        else
            puts "please enter a valid option"
        end
    end

    def get_login
        system "clear"
        puts "Please Enter Username:"
        name = gets.chomp
        current_user = User.where("username = ?",name)[0]

        #binding.pry
        if current_user == []
            puts "This user does not exist. Either create a new user or try a different name."
        else
            puts "Please Enter Password:"
            pass = gets.chomp
            if pass == current_user.password
                @user = current_user
            end
        end
    end

    def create_new_user_and_password
        system "clear"
        puts "Please Enter a Username:"
        name = gets.chomp
        password = ""
        password_check = "1"
        while password != password_check
            puts "Please Enter a Password:"
            password = gets.chomp
            puts "Please Verify Password:"
            password_check = gets.chomp
            if password != password_check
                puts "The passwords did not match"
            end
        end
        @user = User.create(:username => name, :password => password)
    end












    def options
        puts "Hello, #{@user.username}!"
        puts "Please choose an option:"
        puts "1. Search Games"
        puts "2. See Deals"
        puts "3. WishList"
        puts "4. Exit"

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
        elsif input == "3"
            self.wish_menu            
        elsif input == "4" || input =="exit"
            @over = 1
        end
    end

    def wish_menu
        good = false
        while good == false
            good = true
            system "clear"
            puts "Please choose an option"
            puts "1. See Wishlist"
            puts "2. Add Game to Wishlist"
            puts "3. Back"
            input = gets.chomp
            if input == "1"
                self.see_wishlist
            elsif input == "2"
                self.add_game_to_wishlist_menu
            elsif input == "3" or input == "back"
                
            else
                good = false
            end
        end
    end

    def see_wishlist
        count = 1
        puts "#{@user.username}'s Wish List"
        #binding.pry
        wish_array = Wlist.where("user_id = ?", @user.id)
        wish_array.each do |wish|
            name = wish.game.name
            puts "#{count}. #{name}"
            count += 1
        end
        good = false
        if wish_array != []
            while good == false
                good = true
                puts "please select game to view or type back"
                input = gets.chomp
                if input.to_i > 0 && input.to_i <= count
                    #binding.pry
                    self.wishlist_highlight(wish_array[input.to_i - 1].game,wish_array[input.to_i - 1])
                    
                elsif input != "back"
                    good = false
                end
            end
        else
            puts "You have no games in your wishlist. Get some dreams then come back to us!"
        end
    end

    def wishlist_highlight(game, wish)
        system "clear"
        #binding.pry
        puts game.name
        puts "What would you like to do?"
        puts "1. View Pricing"
        puts "2. Remove Game from Wishlist"
        puts "3. Back"
        good = false
        while good == false
            good = true
            input = gets.chomp
            if input == "1"
                #binding.pry
                game.parse_listings.each {|value| puts value}
            elsif input == "2"
                Wlist.delete(wish.id)
            elsif input != "back" && input != "3"
                puts "please make a valid selection"
                good = false
            end
        end
    end



    def add_game_to_wishlist_menu
        system "clear"
        good = false
        puts "What game would you like to search?"
        results_array = search_database_by_name(gets.chomp)
        system "clear"
        #binding.pry
        count = 1
        results_array.each {|result| puts "#{count}. #{result.name}"; count += 1}
        while good == false
            good = true
            puts "Please choose which game you want to add or type back"
            input = gets.chomp
            if input.to_i < count and input.to_i > 0
                game = results_array[input.to_i - 1]
                Wlist.where("user_id = ? and game_id = ?", @user.id, game.id).first_or_create(:user_id => @user.id, :game_id => game.id)
            elsif input != "back"
                good = false
            end
        end




        #binding.pry
    end






    def search_database_by_name(name)
        #Uses the RAWG database to find game info and then stores it to the games table
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
        
        results_array = []
        count = 1
        #builds an array that can be used via numeric selection
        search_array.each do |game|
            results_array << [count, game]
            count += 1
        end
        #prompts player for their choice via numeric selection
        choice = -1
        good = false
        while good == false do
            good = true
            system "clear"
            puts "Please make a choice, #{@user.username}!"
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
                good = false
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
            


