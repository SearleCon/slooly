# == Schema Information
#
# Table name: subscriptions
#
#  id                             :integer          not null, primary key
#  plan_id                        :integer
#  expiry_date                    :date
#  active                         :boolean
#  user_id                        :integer
#  created_at                     :datetime
#  updated_at                     :datetime
#  paypal_customer_token          :string(255)
#  paypal_recurring_profile_token :string(255)
#

FactoryGirl.define do
  factory :subscription do
    bought_on                      Time.zone.now
    expiry_date                    1.month.from_now
    time                           '1 Month'
  end
end
