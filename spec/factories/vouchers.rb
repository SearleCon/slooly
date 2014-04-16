# == Schema Information
#
# Table name: vouchers
#
#  id             :integer          primary key
#  unique_code    :string(255)
#  redeemed_by    :integer
#  valid_until    :timestamp
#  number_of_days :integer
#  created_at     :timestamp        not null
#  updated_at     :timestamp        not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :voucher do
    unique_code "MyString"
    redeemed_by 1
    valid_until "2012-12-11 12:40:48"
    number_of_days 1
  end
end
