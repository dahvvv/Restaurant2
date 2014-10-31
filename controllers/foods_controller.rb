class FoodsController < ApplicationController

  get '/' do
    @foods = Food.order(:name)
    erb :'/foods/index'
  end

  get '/new' do
    erb :'/foods/new'
  end

  post '/' do
  # food = Food.create({:name => params[:name], :cuisine_type => params[:cuisine_type], :price => 0, :allergens => params[:allergens]})
  food = Food.create(params[:food])
  if food.valid?
    price = food.dollars.to_s + food.cents.to_s
    food.update(price: price)
    redirect '/foods/'
  else
    @errors = food.errors.full_messages
    erb :'/foods/new'
  end
  end

  get '/:id' do
    @food = Food.find(params[:id])
    erb :'/foods/show'
  end

  get '/:id/edit' do
    @food = Food.find(params[:id])
    erb :'/foods/edit'
  end

  patch '/:id' do
    food = Food.find(params[:id])
    food.update(params[:food])
    food.save!
    redirect "/foods"
  end

  delete '/:id' do
    food = Food.find(params[:id])
    food.delete
    redirect '/foods/'
  end

end
