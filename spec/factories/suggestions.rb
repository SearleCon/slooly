# == Schema Information
#
# Table name: suggestions
#
#  id         :integer          primary key
#  subject    :string(255)
#  comment    :text
#  email      :string(255)
#  created_at :timestamp        not null
#  updated_at :timestamp        not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :suggestion do
    subject "MyString"
    comment "MyText"
    email "MyString"
  end
end
