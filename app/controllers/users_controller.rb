class UsersController < ApplicationController
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
    @user.name = params[:user][:name]
    @user.save
    redirect_to "/users/#{@user.id}"
  end

  def destroy
    @user.active = false
    @user.save
    redirect_to '/'
  end


  private
  def set_user
    @user = User.find(params[:id])
  end

end
