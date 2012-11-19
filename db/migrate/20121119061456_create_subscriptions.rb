class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.datetime :bought_on
      t.integer :plan_id
      t.date :expiry_date
      t.string :time
      t.boolean :active
      t.string :paypal_id
      t.integer :user_id

      t.timestamps
    end
  end
end
