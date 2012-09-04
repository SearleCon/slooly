# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invoice do
    invoice_number "MyString"
    due_date "2012-09-04"
    amount "9.99"
    description "MyText"
    status_id 1
    client_id 1
  end
end
