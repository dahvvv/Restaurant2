require 'bundler'
Bundler.require(:default)

Dir.glob("./{helpers,models,controllers}/*.rb").each do |file|
  require file
  puts "require #{file}"
end

require_relative 'connection'

map('/foods'){ run FoodsController }
map('/parties'){ run PartiesController }
map('/orders'){ run OrdersController }
map('/managers'){ run ManagersController }
map('/sessions'){ run SessionsController }
map('/'){ run ApplicationController }