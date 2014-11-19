class AddUserIdAndClientIdIndexesToHistories < ActiveRecord::Migration
  def change
    add_index :histories, :user_id
    add_index :histories, :client_id
  end
end
