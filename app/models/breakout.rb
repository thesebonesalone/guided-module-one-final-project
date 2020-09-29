class TextAdventure
    #This is an Easter Egg game. Fun!
    attr_accessor :hp, :name, :over, :demeanor, :location
    def initialize
        system "clear"
        puts "You're an adventurous one aren't you? What's your name?"
        
        @name = gets.chomp

        puts "Alright, #{@name}! Let's go on an adventure!"
        sleep(3)
        @demeanor = "Chill"
        @location = "Somewhere warm"
        @hp = 5
        @over = 0
    end
    def hud
        system "clear"
        puts "HP: #{@hp} Demeanor: #{@demeanor} Location: #{@location}"
    end
    def choose(message,choices)
        puts message
        count = 1
        choices.each {|choice| puts "#{count}. #{choice}"; count += 1}
        good = false
        while good == false do
            input = gets.chomp
            if input == "exit"
                @over = 1
            elsif input.to_i > 0 && input.to_i <= count
                good = true
            end
        end
        if @over == 0
        return input.to_i
        end

    end  

    def start
        self.hud
        input = self.choose("You are a goose. A large man is running towards you brandishing a shovel.", ["Run Away","Attack"])
        if input == 1
            puts "Smart move. You're not that strong."
            sleep 3
            self.running_away
        else
            puts "Despite your general beakiness and attempts to honk you were bludgeoned by a shovel."
            self.game_over
        end
    end

    def running_away
        @location = "Somewhere less warm"
        @demeanor = "A bit cross"
        self.hud
        input = self.choose("While running away you see a large loaf of bread. It's the good stuff too, you can't imagine how it got here.", ["Eat the bread","Keep fleeing","Face your assailant"])
        if input == 1
            puts "You somehow consume the entire loaf in a single bit. You feel energized, and ready to face your foes!"
            @hp += 10
            @demeanor = "Relatively Buff"
            sleep 3
            self.getting_closer
        elsif input == 2
            puts "Despite how enticing the bread looks you continue to waddle away as fast as you can. Perhaps the opportunity for reprisal will arrive at a later time."
            sleep 4
            self.running_away_2
        else
            puts "Having passed on the bread you feel less than capable of dealing with this, the large man bludgeons you with a shovel."
            self.game_over
        end
    end
    def getting_closer
        @location = "In the clutches of the beast"
        self.hud
        input = self.choose("Despite your best efforts the man is gaining on you. You have come to a crossroads in your destiny. Either you face your fears, or attempt to outrun the inevitable.", ["Flee, with gusto","Face your assailant!"])
        if input == 1 && @hp > 5
                puts "The man is no match for your wrath, empowered by really excellent bread you smite your foe against the lakeside. You, #{@name} the goose, have won. But at what cost?"
                self.game_over
            else
                puts "You have tuckered your little goose heart out by running away. If only you had eaten something this morning! Then you may have had the vigor to face all comers. The last thing you see is the large man bludgeoning you with a shovel."
                self.game_over
        end
    end
    def running_away_2
        @location = "Far too far from home."
        @demeanor = "Desperate"
        self.hud
        input = self.choose("You are exhausted, the man is gaining. Your road has run out. You must face the beast.",["Plea to the All-Honk","Excape to the sky","Face your assailant!"])
        if input == 1
            puts "You call upon the God of geese, a huge chorus of honks descend from the sky. Your assailant flees in terror, alas it is in vain. The horde of feathers engulfs him and when it passes nothing is left but the shovel. You have won, but at what cost."\
        elsif input == 2
            puts "In a last ditch effort to survive you take flight. You will live to honk another day, but you will never return to the lands of your fathers. It is a day of solemnity, you fly on to more adventures."
        else
            puts "The man is far too strong, and you are far too weak. You fall beneath the weight of the shovel, a life poorly spent."
        end
        self.game_over
    end
    



    def game_over
        sleep(5)
        @over = 1
    end
end