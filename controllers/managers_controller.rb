class ManagersController < ApplicationController

  get '/new' do
    erb :'/managers/new'
  end

  post '/' do
    manager = Manager.new(params[:manager])
    manager.password = (params[:password])
    manager.save!
    redirect '/'
  end

  get '/:id' do
    @manager = Manager.find(params[:id])
    erb :'/managers/edit'
  end

  patch "/:id" do
    manager = Manager.find(params[:id])
    manager.update(params[:manager])
    manager.password=(params[:new_password])
    manager.save!
    redirect '/'
  end

end