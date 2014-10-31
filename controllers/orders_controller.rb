class OrdersController < ApplicationController

  get '/' do
    @party_id = params[:party_id]
    @orders = Order.where(party_id: "#{params[:party_id]}")
    @table_number = Party.find("#{params[:party_id]}").table_number
    erb :'/orders/index'
  end

  get '/new' do
    @party = Party.find(params[:party_id])
    if @party.paid != true
      @orders = Order.where(:party_id => @party.id)
      @foods = Food.order(:name)
      @party_foods = @party.foods
      erb :'/orders/new'
    else
      redirect "/errors/order_on_paid_party"
    end
  end

  post '/' do
    order = Order.create(params[:order])
    party = Party.find(order.party_id)
    redirect "/parties/#{party.id}"
  end

  get '/:id' do
    @order = Order.find(params[:id])
    @party = Party.find(@order.party_id)
    erb :'/orders/show'
  end

  get '/:id/edit' do
    @order = Order.find(params[:id])
    @food = Food.find(@order.food_id)
    @foods = Food.order(:name)
    erb :'/orders/edit'
  end

  patch '/:id' do
    order = Order.find(params[:id])
    party_id = order.party_id
    order.update(params[:order])
    redirect "/parties/#{party_id}"
  end

  patch '/delivered/:id' do
    order = Order.find(params[:id])
    order.update(delivered: true)
    order.save!
    party_id = order.party_id
    redirect "/parties/#{party_id}"
  end


  delete '/:id' do
    order = Order.find(params[:id])
    party_id = order.party_id
    order.destroy
    redirect "/parties/#{party_id}"
  end

end
