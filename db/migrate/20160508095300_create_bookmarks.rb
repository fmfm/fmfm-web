class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.integer   :entry_id,      :null => false
      t.integer   :user_id,       :null => false
      t.text      :content
      t.integer   :count,         :null => false, :default => 0
      t.boolean   :active,        :null => false, :default => true
      t.timestamps  :null => false
    end
  end
end
