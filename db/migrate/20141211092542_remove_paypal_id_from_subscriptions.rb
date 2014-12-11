class RemovePaypalIdFromSubscriptions < ActiveRecord::Migration
  def change
    remove_column :subscriptions, :paypal_id
  end
end
