# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :voucher do
    unique_code "MyString"
    redeemed_by 1
    valid_until "2012-12-11 12:40:48"
    number_of_days 1
  end
end
