# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :setting do
    send_from_name "MyString"
    email_copy_to "MyString"
    days_between_chase 1
    days_before_pre_due 1
    payment_method_message "MyText"
    pre_due_reminder false
    pre_due_subject "MyString"
    pre_due_message "MyText"
    due_reminder false
    due_subject "MyString"
    due_message "MyText"
    overdue1_subject "MyString"
    overdue1_message "MyText"
    overdue2_subject "MyString"
    overdue2_message "MyText"
    overdue3_subject "MyString"
    overdue3_message "MyText"
    final_demand_subject "MyString"
    final_demand_message "MyText"
    user_id 1
  end
end
