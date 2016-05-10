class CreateUserTokens < ActiveRecord::Migration
  def change
    create_table :user_tokens do |t|
      t.integer     :user_id,   :null => false
      t.string      :token,     :null => false
      t.boolean     :active,    :null => false, :default => true
      t.datetime    :expired_at
      t.timestamps  :null => false
    end
  end
end
