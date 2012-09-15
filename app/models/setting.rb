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