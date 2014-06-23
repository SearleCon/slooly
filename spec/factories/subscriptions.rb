# == Schema Information
#
# Table name: subscriptions
#
#  id                             :integer          primary key
#  bought_on                      :timestamp
#  plan_id                        :integer
#  expiry_date                    :date
#  time                           :string(255)
#  active                         :boolean
#  paypal_id                      :string(255)
#  user_id                        :integer
#  created_at                     :timestamp        not null
#  updated_at                     :timestamp        not null
#  paypal_customer_token          :string(255)
#  paypal_recurring_profile_token :string(255)
#

FactoryGirl.define do
  factory :subscription do
    bought_on                      Time.zone.now
    expiry_date                    Date.today + 1.months
    time                           '1 Month'
    active                         false
  end
end
