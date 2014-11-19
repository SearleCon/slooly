class AddUserIdIndexToPaymentNotifications < ActiveRecord::Migration
  def change
    add_index :payment_notifications, :user_id
  end
end
