# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :announcement do
    headline "MyString"
    description "MyText"
    posted_by "MyString"
  end
end
