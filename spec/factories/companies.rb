# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  logo_path  :string(255)
#  address    :string(255)
#  city       :string(255)
#  post_code  :string(255)
#  telephone  :string(255)
#  fax        :string(255)
#  email      :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  image      :string(255)
#

FactoryGirl.define do
  factory :company do
    name        { Faker::Company.name }
    address     { Faker::Address.street_name }
    city        { Faker::Address.city }
    post_code   { Faker::Address.postcode }
    telephone   { Faker::PhoneNumber.phone_number }
    fax         { Faker::PhoneNumber.phone_number }
    email       { Faker::Internet.email }
  end
end
