class AuthController < ApplicationController

  def callback
    auth = request.env["omniauth.auth"]
    user_sign = UserSign.where(:provider => auth[:provider], :uid => auth[:uid]).first_or_initialize

    if user_sign.id
    else
      ActiveRecord::Base.transaction do
        user = User.new
        user.name = auth[:info][:name]
        user.save
        user_sign.user_id = user.id
        user_sign.save
      end
    end

    unless user_sign.user
      raise
    end

    set_login_user_id(user_sign.user_id)

    redirect_to "/users/#{user_sign.user_id}"
  end

  def failure
    render :text => params[:message]
  end

  private
  def set_login_user_id(user_id)
    session[:user_id] = user_id
  end

end