# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :history do
    date_sent "2012-09-17"
    client_id 1
    user_id 1
    subject "MyString"
    message "MyText"
    reminder_type "MyString"
    sent false
    email_return_code "MyString"
    email_sent_from "MyString"
    copy_email "MyString"
    email_sent_to "MyString"
  end
end
