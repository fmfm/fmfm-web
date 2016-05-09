class HomeController < ApplicationController

  def index
    @bookmarks = Bookmark.includes(:entry).active.order(:id).reverse_order.page(params[:page])
  end

end
