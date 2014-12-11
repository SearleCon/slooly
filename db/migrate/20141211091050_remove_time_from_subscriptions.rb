class RemoveTimeFromSubscriptions < ActiveRecord::Migration
  def change
    remove_column :subscriptions, :time
  end
end
