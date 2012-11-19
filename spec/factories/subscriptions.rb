# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription do
    bought_on "2012-11-19 08:14:57"
    plan_id 1
    expiry_date "2012-11-19"
    time "MyString"
    active false
    paypal_id "MyString"
    user_id 1
  end
end
