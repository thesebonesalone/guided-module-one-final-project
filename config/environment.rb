require "bundler/setup"
require "sinatra/activerecord"
require_relative '../app/models/game.rb'
require_relative '../app/models/store.rb'
require_relative '../app/models/listing.rb'
require_relative '../app/models/interact.rb'
require_relative '../app/models/breakout.rb'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
