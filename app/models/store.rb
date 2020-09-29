class Store < ActiveRecord::Base
    has_many :listings
    has_many :games, through: :listings
end