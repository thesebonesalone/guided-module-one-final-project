class Game < ActiveRecord::Base
    has_many :listings
    has_many :stores, through: :listings
    has_many :users, through: :wlists
    has_many :wlists

    def self.return_all_games_with_n(name)
            Game.where("name LIKE ?", "%#{name}%")
    end

    def parse_listings
        self.listings.map {|value| "#{value.store.name} is selling #{value.game.name} for #{(value.price).round(2)}"}
    end

    def self.returns_top_10_discounted_games
        top_ten = Listing.all.sort_by do |listing|
            listing.price / listing.game.msrp
        end
        if top_ten != []
            count = 0
            10.times do
                game = top_ten[count].game
                puts "#{game.name} is discounted at #{(top_ten[0].price / game.msrp).round(2)}% off at #{top_ten[0].store.name} for a total of #{(top_ten[0].price).round(2)}"
                count += 1
                break if count > top_ten.length
            end
        else
            puts "The game list is unpopulated! Seach some games and come back!"
        end
    end 
        
end