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
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  time_zone              :string(255)
#

FactoryGirl.define do
  before(:create) do
    User.skip_callback(:create, :after, :setup)
    User.skip_callback(:commit, :after, :send_registration_confirmation)
  end
  after(:create) do
    User.set_callback(:create, :after, :setup)
    User.set_callback(:commit, :after,  :send_registration_confirmation)
  end

  factory :user do
    name "Test User"
    email { Faker::Internet.email }
    password "please123"
    setting
    company
    time_zone 'Pretoria'

    after(:create) do |user, evaluator|
      plan = create(:free_trial)
      create(:subscription, plan: plan, user: user, active: true)
    end
  end
end
