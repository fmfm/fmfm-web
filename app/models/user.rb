class User < ActiveRecord::Base

  has_many :user_signs
  has_many :user_tokens
  has_many :bookmarks

  scope :active, lambda { where(:active => true) }

  validates :name, :presence => true

end
