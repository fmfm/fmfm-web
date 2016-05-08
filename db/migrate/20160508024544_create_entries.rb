class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.text        :url,     :null => false
      t.text        :title
      t.text        :description
      t.text        :image
      t.boolean     :active,  :null => false, :default => true
      t.timestamps  :null => false
    end
  end
end
