class BookmarksController < ApplicationController
  include FetchEntry
  before_action :login_user_only

  def create
    unless login_user
      raise
    end

    if params[:entry_id]
      id = params[:id]
      entry = Entry.find(id)
    elsif params[:url]
      url = params[:url]
      entry = get_entry(url)
    end

    bookmark = Bookmark.where(:entry_id => entry.id, :user_id => login_user.id).first_or_initialize
    bookmark.content = params[:content]&.strip
    bookmark.count += 1 if 10 > bookmark.count
    bookmark.save

    respond_to do |format|
      format.html do
        redirect_to "/users/#{login_user.id}"
      end
      format.json do
        render :json => bookmark
      end
    end

  end

end
