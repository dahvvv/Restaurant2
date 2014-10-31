module Sinatra
  module AuthenticationHelper
    def current_manager
      if session[:current_manager]
        @current_manager ||= Manager.find(session[:current_manager])
      else
        nil
      end
    end

    def authenticate!
      redirect '/' unless current_manager
    end
  end
end
