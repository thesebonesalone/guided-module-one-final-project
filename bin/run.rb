require_relative '../config/environment.rb'
require "faker"
require "pry"

run = Interact.new
while run.over == 0 do
    run.options

end
exit
