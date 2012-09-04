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
