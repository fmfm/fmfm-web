class BookmarksController < ApplicationController
  include FetchEntry

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

    redirect_to "/users/#{login_user.id}"
  end

end
