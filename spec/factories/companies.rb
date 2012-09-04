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
