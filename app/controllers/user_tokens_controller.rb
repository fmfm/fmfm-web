class UserTokensController < ApplicationController
  before_action :login_user_only
  before_action :set_user_token, :only => [:show, :destroy]

  def index
    @user_tokens = UserToken.active.where(:user_id => login_user.id).page(params[:page])
    render :json => SecureRandom.hex(64)
  end

  def show
  end


  def create
    user_token = UserToken.new
    user_token.user_id = login_user.id
    user_token.token = SecureRandom.hex(64)
    user_token.expired_at = 3.month.since
    user_token.save
    redirect_to "/user_tokens/#{user_token.id}"
  end

  def destroy
    @user_token.active = false
    @user_token.save
    redirect_to '/user_tokens'
  end


  private
  def login_user_only
    unless login_user
      raise
    end
  end

  def set_user_token
    @user_token = UserToken.where(:user_id => login_user.id).find(params[:id])
  end

end
