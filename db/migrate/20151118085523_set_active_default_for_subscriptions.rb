class SetActiveDefaultForSubscriptions < ActiveRecord::Migration
  def change
    change_column_default :subscriptions, :active, true
  end
end
