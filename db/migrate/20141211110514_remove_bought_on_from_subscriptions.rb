class RemoveBoughtOnFromSubscriptions < ActiveRecord::Migration
  def change
    remove_column :subscriptions, :bought_on
  end
end
