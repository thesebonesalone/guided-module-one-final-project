class Listing < ActiveRecord::Base
    belongs_to :game
    belongs_to :store
end