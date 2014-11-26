# == Schema Information
#
# Table name: users
#
#  id                     :integer          primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :timestamp
#  remember_created_at    :timestamp
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :timestamp
#  last_sign_in_at        :timestamp
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :timestamp        not null
#  updated_at             :timestamp        not null
#  name                   :string(255)
#

FactoryGirl.define do
  factory :user do
    name "Test User"
    email { Faker::Internet.email }
    password "please123"
    setting
    company



    factory :subscribed_user do
      after(:create) do |user, evaluator|
        plan = create(:plan, free: true, duration: 1, description: 'Free Trial')
        create(:subscription, plan: plan, user: user, active: true)
      end
    end
  end
end
