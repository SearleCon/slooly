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

class Setting < ActiveRecord::Base
  attr_accessible :days_before_pre_due, :days_between_chase, :due_message, :due_reminder, :due_subject, :email_copy_to, :final_demand_message, :final_demand_subject, :overdue1_message, :overdue1_subject, :overdue2_message, :overdue2_subject, :overdue3_message, :overdue3_subject, :payment_method_message, :pre_due_message, :pre_due_reminder, :pre_due_subject, :send_from_name, :user_id
  belongs_to      :user
  
  validates       :days_between_chase, :days_before_pre_due, :presence => true  
  validates_inclusion_of :days_between_chase, :in => 1..31, :message => "can only be between 0 and 31."
  validates_inclusion_of :days_before_pre_due, :in => 1..31, :message => "can only be between 0 and 31."
  
  
  def self.for_user(user) 
      where("user_id = ?", user)
  end  
end
