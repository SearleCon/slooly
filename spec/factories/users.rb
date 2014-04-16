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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name 'Test User'
    email 'example@example.com'
    password 'please'
    password_confirmation 'please'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end
end
