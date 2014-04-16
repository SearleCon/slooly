# == Schema Information
#
# Table name: clients
#
#  id             :integer          primary key
#  business_name  :string(255)
#  contact_person :string(255)
#  address        :string(255)
#  city           :string(255)
#  post_code      :string(255)
#  telephone      :string(255)
#  fax            :string(255)
#  email          :string(255)
#  user_id        :integer
#  created_at     :timestamp        not null
#  updated_at     :timestamp        not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :client do
    business_name "MyString"
    contact_person "MyString"
    address "MyString"
    city "MyString"
    post_code "MyString"
    telephone "MyString"
    fax "MyString"
    email "MyString"
    user_id 1
  end
end
