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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription do
    bought_on "2012-11-19 08:14:57"
    plan_id 1
    expiry_date "2012-11-19"
    time "MyString"
    active false
    paypal_id "MyString"
    user_id 1
  end
end
