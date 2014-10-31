class ApplicationController < Sinatra::Base
  helpers Sinatra::AuthenticationHelper

  set :views, File.expand_path("../../views", __FILE__)
  set :public_folder, File.expand_path("../../public_folder", __FILE__)

  enable :sessions, :method_override

  # SIGNING IN AS MANAGER:
  # USERNAME:  Daphne
  # PASSWORD:  password

  # TABLE COLORS:
  # GREY:  no guests are seated
  # BLUE:  guests have been seated
  # RED:  food is ready the kitchen, but NOT yet delivered to the table
  # GREEN:  table has paid


  get '/console' do
    binding.pry
  end

  get '/' do
    @parties = Party.all
    erb :index
  end

  get '/chef_view' do
    @orders = Order.list_for_chef
    erb :chef_view
  end

  post '/chef_view' do
    order = Order.find(params[:id])
    order.update(:ready => params[:ready])
    redirect '/chef_view'
  end

  get '/receipt_history' do
    @receipts = Receipt.all.order(id: :desc)
    erb :'/receipts/history'
  end
  # get '/receipt_history' do
  #   @receipts = Receipt.order(created_at: :desc)
  #   erb :'/receipts/show'
  # end


  get '/errors/order_on_paid_party' do
    erb :'/errors/order_on_paid_party'
  end

  get '/auth' do
    authenticate!
    "ooo"
  end

end