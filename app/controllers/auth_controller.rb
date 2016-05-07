class AuthController < ApplicationController

  def callback
    auth = request.env["omniauth.auth"]
    redirect_to '/'
  end

  def failure
    render :text => params[:message]
  end

  private
  def set_login_user_id(user_id)
    session[:user_id] = user_id
  end

end