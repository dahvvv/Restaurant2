require 'bundler'
Bundler.require

require 'sinatra/activerecord/rake'
require './connection'
require 'csv'
require_relative 'models/food'
require_relative 'models/manager'

namespace :db do

  foods = "Foods.csv"

  desc 'create database restaurant2_db'
  task :create_db do
    conn = PG::Connection.open()
    conn.exec('CREATE DATABASE restaurant2_db;')
    conn.close
  end

  desc 'drop database restaurant2_db'
  task :drop_db do
    conn = PG::Connection.open()
    conn.exec('DROP DATABASE restaurant2_db;')
    conn.close
  end

  desc 'add first manager'
  task :add_manager do
    manager = Manager.new({username: 'Gerdo', avatar_url: 'http://www.underwatercolours.com/blog/wp-includes/images/pod/Cyrinda_the_goat.jpg'})
    manager.password=('password')
    manager.save!
  end

  desc 'populate foods'
  task :populate_foods do
    CSV.foreach(foods, headers: true) do |csv|
      name = csv[0]
      cuisine_type = csv[1]
      cents = csv[2]
      allergens = csv[3]
      img_url = csv[4]
      to_kitchen = csv[5]
      Food.create!(
        name: name,
        cuisine_type: cuisine_type,
        cents: cents,
        allergens: allergens,
        img_url: img_url,
        to_kitchen: to_kitchen
        )
    end
  end

end