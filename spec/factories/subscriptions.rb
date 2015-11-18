# == Schema Information
#
# Table name: subscriptions
#
#  id                             :integer          not null, primary key
#  plan_id                        :integer
#  expiry_date                    :date
#  active                         :boolean          default(TRUE)
#  user_id                        :integer
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  paypal_customer_token          :string(255)
#  paypal_recurring_profile_token :string(255)
#

FactoryGirl.define do
  factory :subscription do
    expiry_date   1.month.from_now
    active true
    association :plan, factory: :free_trial
  end
end
