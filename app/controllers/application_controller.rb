class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  helper_method :login_user, :login_user_id


  def login_user
    if login_user_id
      @login_user ||= User.active.where(:id => login_user_id).first
    end
  end

  private
  def login_user_id
    session[:user_id]
  end

end
