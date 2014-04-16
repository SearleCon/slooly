# == Schema Information
#
# Table name: companies
#
#  id         :integer          primary key
#  name       :string(255)
#  logo_path  :string(255)
#  address    :string(255)
#  city       :string(255)
#  post_code  :string(255)
#  telephone  :string(255)
#  fax        :string(255)
#  email      :string(255)
#  user_id    :integer
#  created_at :timestamp        not null
#  updated_at :timestamp        not null
#  image      :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :company do
    name "MyString"
    logo_path "MyString"
    address "MyString"
    city "MyString"
    post_code "MyString"
    telephone "MyString"
    fax "MyString"
    email "MyString"
    user_id 1
  end
end
