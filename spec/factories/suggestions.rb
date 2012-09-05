# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :suggestion do
    subject "MyString"
    comment "MyText"
    email "MyString"
  end
end
