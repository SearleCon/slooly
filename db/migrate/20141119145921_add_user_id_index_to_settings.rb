class AddUserIdIndexToSettings < ActiveRecord::Migration
  def change
    add_index :settings, :user_id
  end
end
