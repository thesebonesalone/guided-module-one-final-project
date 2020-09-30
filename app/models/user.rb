class User < ActiveRecord::Base
    has_many :wlists
    has_many :games, through: :wlists
end