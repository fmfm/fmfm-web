class UsersController < ApplicationController
  before_action :login_user_only, :only => [:edit, :update, :destroy]
  before_action :set_user, :only => [:show, :edit, :update, :destroy]

  def index
    @users = User.page(params[:page])
  end

  def show
    @bookmarks = Bookmark.includes(:entry).active.where(:user_id => @user.id).order(:id).reverse_order.page(params[:page])
  end

  def edit
  end

  def update
    login_user.name = params[:user][:name]
    login_user.save
    redirect_to "/users/#{login_user.id}"
  end

  def destroy
    login_user.active = false
    login_user.save
    redirect_to '/'
  end


  private
  def set_user
    @user = User.find(params[:id])
  end

end
