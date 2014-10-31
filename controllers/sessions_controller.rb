class SessionsController < ApplicationController

  get '/new' do
    erb :'/sessions/new'
  end

  post '/' do
    redirect '/sessions/new' unless manager = Manager.find_by(username: params[:manager][:username])
    if manager.password == params[:password]
      session[:current_manager] = manager.id
      redirect '/'
    else
      redirect '/sessions/new'
    end
  end

  delete '/' do
    session[:current_manager] = nil
    redirect '/'
  end

end
