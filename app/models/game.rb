class Game < ActiveRecord::Base
    has_many :listings
    has_many :stores, through: :listings

    def self.return_all_games_with_n(name)
            Game.where("name LIKE ?", "%#{name}%")
    end

    def parse_listings
        self.listings.map {|value| "#{value.store.name} is selling #{value.game.name} for #{value.price}"}
    end

    def self.returns_top_10_discounted_games
      top_ten = Listing.all.sort_by do |listing|
        listing.price / listing.game.msrp
        end
        count = 0
        10.times do
         game = top_ten[count].game
        puts "#{game.name} is discounted at #{(top_ten[0].price / game.msrp).round(2)}% off at #{top_ten[0].store.name} for a total of #{(top_ten[0].price).round(2)}"
         count += 1
        end
    end 
        
end