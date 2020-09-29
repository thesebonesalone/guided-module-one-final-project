class Game < ActiveRecord::Base
    has_many :listings
    has_many :stores, through: :listings
end