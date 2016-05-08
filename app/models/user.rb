class User < ActiveRecord::Base

  has_many :user_signs
  has_many :bookmarks

end
