class PartiesController < ApplicationController

  get '/new/:table' do
    @table_number = params[:table]
    erb :'/parties/new'
  end

  get '/:id' do
    @party = Party.find(params[:id])
    @orders = Order.where(:party_id => @party.id)
    erb :'/parties/show'
  end

  post '/' do
    party = Party.create(params[:party])
    redirect "/parties/#{party.id}"
  end

  get '/:id/edit' do
    @party = Party.find(params[:id])
    erb :'/parties/edit'
  end

  patch '/:id' do
    party = Party.find(params[:id])
    party.update(params[:party])
    redirect "/parties/#{party.id}"
  end

  delete '/:id' do
    party = Party.find(params[:id])
    Order.where(:party_id => party.id).destroy_all
    party.delete
    redirect '/'
  end


  get '/:id/receipts' do
    @party = Party.find(params[:id])
    @total = params[:total]
    @orders = Order.where(:party_id => @party.id)
    receipt_file = File.open('public_folder/receipt.txt', 'w')
    receipt_file << "hi"
    receipt_file.close
    receipt_file = File.open('public_folder/receipt.txt', 'a')
    receipt_file << "Receipt for table #{@party.table_number}\n\n"
    @orders.each do |order|
      receipt_file << order.food_name.to_s + ":  $" + order.charge.to_s + "\n"
    end
    receipt_file << "\n\nSUM:  $" + @total
    receipt_file << "\nTIP:_____________________________"
    receipt_file << "\nTOTAL:_____________________________\n\nSuggested Tip:"
    receipt_file << "\n25% = $" + (@total.to_f * 0.25).round(2).to_s
    receipt_file << "\n20% = $" + (@total.to_f * 0.2).round(2).to_s
    receipt_file << "\n15% = $" + (@total.to_f * 0.15).round(2).to_s
    receipt_file.close
    erb :'/receipts/show'
  end

  post '/:id/receipts' do
    id = params[:id]
    party = Party.find(id)
    party.update(paid: true)
    Receipt.create(params[:receipt])
    redirect "/parties/#{id}"
  end

end
