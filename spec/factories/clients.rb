# == Schema Information
#
# Table name: clients
#
#  id             :integer          not null, primary key
#  business_name  :string(255)
#  contact_person :string(255)
#  address        :string(255)
#  city           :string(255)
#  post_code      :string(255)
#  telephone      :string(255)
#  fax            :string(255)
#  email          :string(255)
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :client do
    business_name   { Faker::Company.name }
    contact_person  { Faker::Name.name }
    address         { Faker::Address.street_name }
    city            { Faker::Address.city }
    post_code       { Faker::Address.postcode }
    telephone       { Faker::PhoneNumber.phone_number }
    fax             { Faker::PhoneNumber.phone_number }
    email           { Faker::Internet.email }
    user
  end
end
