# == Schema Information
#
# Table name: plans
#
#  id          :integer          primary key
#  description :string(255)
#  duration    :integer
#  cost        :decimal(, )
#  active      :boolean
#  created_at  :timestamp        not null
#  updated_at  :timestamp        not null
#  free        :boolean
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :plan do
    description "MyString"
    duration 1
    cost "9.99"
    active false
  end
end
