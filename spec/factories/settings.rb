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


FactoryGirl.define do
  factory :setting do
  end
end
