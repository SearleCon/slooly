# == Schema Information
#
# Table name: statuses
#
#  id          :integer          primary key
#  description :string(255)
#  created_at  :timestamp        not null
#  updated_at  :timestamp        not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :status do
    description "MyString"
  end
end
