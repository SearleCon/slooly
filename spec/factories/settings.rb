# == Schema Information
#
# Table name: settings
#
#  id                     :integer          primary key
#  send_from_name         :string(255)
#  email_copy_to          :string(255)
#  days_between_chase     :integer
#  days_before_pre_due    :integer
#  payment_method_message :text
#  pre_due_reminder       :boolean
#  pre_due_subject        :string(255)
#  pre_due_message        :text
#  due_reminder           :boolean
#  due_subject            :string(255)
#  due_message            :text
#  overdue1_subject       :string(255)
#  overdue1_message       :text
#  overdue2_subject       :string(255)
#  overdue2_message       :text
#  overdue3_subject       :string(255)
#  overdue3_message       :text
#  final_demand_subject   :string(255)
#  final_demand_message   :text
#  user_id                :integer
#  created_at             :timestamp        not null
#  updated_at             :timestamp        not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :settings do
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
