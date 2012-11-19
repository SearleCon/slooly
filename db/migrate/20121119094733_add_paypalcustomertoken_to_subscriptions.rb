class AddPaypalcustomertokenToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :paypal_customer_token, :string
  end
end
