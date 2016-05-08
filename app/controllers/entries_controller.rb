class EntriesController < ApplicationController
  include FetchEntry

  def index
    @entries = Entry.page(params[:page])
  end

  def show
    @entry = Entry.find(params[:id])
  end

end
