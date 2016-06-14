class LoginController < ApplicationController
  def index
    session[:user_name] = params[:user_name]
    
    render nothing: true
  end
end