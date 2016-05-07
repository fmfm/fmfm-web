class CreateUserSigns < ActiveRecord::Migration
  def change
    create_table :user_signs do |t|
      t.integer     :user_id,   :null => false
      t.string      :provider,  :null => false
      t.string      :uid,       :null => false
      t.timestamps  :null => false
    end
  end
end
