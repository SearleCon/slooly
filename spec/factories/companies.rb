# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string(255)      default("Your Company Name")
#  address    :string(255)      default("44 Street Name, Suburb")
#  city       :string(255)      default("Best City")
#  post_code  :string(255)      default("1234")
#  telephone  :string(255)      default("555 345 6789")
#  fax        :string(255)      default("People still fax?")
#  email      :string(255)      default("you@example.com")
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
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
