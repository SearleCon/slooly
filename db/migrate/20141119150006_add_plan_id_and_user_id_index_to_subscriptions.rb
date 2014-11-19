class AddPlanIdAndUserIdIndexToSubscriptions < ActiveRecord::Migration
  def change
    add_index :subscriptions, :plan_id
    add_index :subscriptions, :user_id
  end
end
