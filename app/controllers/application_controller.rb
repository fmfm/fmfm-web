class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  helper_method :login_user, :login_user_id


  def login_user
    if login_user_id
      @login_user ||= User.active.where(:id => login_user_id).first
    elsif params[:token]
      @login_user_token ||= UserToken.where(:token => params[:token]).first
      @login_user ||= User.active.find(@login_user_token.user_id)
    end
  end

  def login_user_only
    unless login_user
      raise
    end
  end

  private
  def login_user_id
    session[:user_id]
  end

end
