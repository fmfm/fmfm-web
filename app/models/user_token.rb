class UserToken < ActiveRecord::Base

  belongs_to :user

  scope :active, lambda { where(:active => true) }

end
