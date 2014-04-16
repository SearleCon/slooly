# == Schema Information
#
# Table name: announcements
#
#  id          :integer          primary key
#  headline    :string(255)
#  description :text
#  posted_by   :string(255)
#  created_at  :timestamp        not null
#  updated_at  :timestamp        not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :announcement do
    headline "MyString"
    description "MyText"
    posted_by "MyString"
  end
end
