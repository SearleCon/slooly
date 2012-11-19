# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :plan do
    description "MyString"
    duration 1
    cost "9.99"
    active false
  end
end
