class Game < ActiveRecord::Base
    has_many :listings
    has_many :stores, through: :listings

    def self.return_all_games_with_n(name)
        self.where("name LIKE ?", "%#{name}%")
    end
    def parse_listings
        self.listings.sort_by{|listing| listing.price}.map {|listing| "#{listing.store.name} has #{self.name} for #{listing.price}."}
    end
end