class Bookmark < ActiveRecord::Base

  belongs_to :entry
  belongs_to :user

  scope :active, lambda { where(:active => true) }

end
