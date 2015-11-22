# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string(255)
#  time_zone              :string
#

FactoryGirl.define do
  factory :user do
    name "Test User"
    email { Faker::Internet.email }
    password "please123"
    time_zone 'Pretoria'

    after(:create) do |user, evaluator|
      plan = create(:free_trial)
      create(:subscription, plan: plan, user: user, active: true)
      create(:company, user: user)
      create(:setting, user: user)
    end
  end
end
