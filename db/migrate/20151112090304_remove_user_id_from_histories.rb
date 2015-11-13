class RemoveUserIdFromHistories < ActiveRecord::Migration
  def change
    remove_column :histories, :user_id
  end
end
