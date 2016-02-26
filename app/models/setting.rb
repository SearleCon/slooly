# == Schema Information
#
# Table name: settings
#
#  id                                    :integer          not null, primary key
#  reminder_email_sender_name            :string(255)      default("Your Business")
#  reminder_email_cc_address             :string(255)      default("copy@example.com")
#  chasing_interval                      :integer          default(7)
#  pre_due_interval                      :integer          default(2)
#  payment_method_message                :text             default("(Deposit or Transfer to:\nBank:\nAccount:\nAccount Type:\nBranch Code:)")
#  send_pre_due_reminder_email           :boolean          default(TRUE)
#  pre_due_reminder_email_subject        :string(255)      default("Friendly Reminder: Payment due soon")
#  pre_due_reminder_email_message        :text             default("This is a friendly reminder that payment for the above invoice is due in a couple of days time.\nWe really do appreciate your timely payment.\n\nPayment can be made by any of the methods listed below.\n\nWe appreciate your support and value you as our customer.\n\nKind regards,")
#  send_due_reminder_email               :boolean          default(TRUE)
#  due_reminder_email_subject            :string(255)      default("Payment Due Today")
#  due_reminder_email_message            :text             default("This is a friendly reminder that payment for the above invoice is due today.\nWe really do appreciate your timely payment.\n\nPayment can be made by any of the methods listed below.\nIf you have already paid, please ignore this email.\n\nWe appreciate your support.\n\nKind regards,")
#  first_overdue_reminder_email_subject  :string(255)      default("Important Reminder: Payment overdue")
#  first_overdue_reminder_email_message  :text             default("Please note that payment for the above invoice is now overdue.\nWe really do appreciate your business and timeous payment.\n\nPayment can be made by any of the methods listed below.\nIf you have already paid, please email or fax proof of payment to us (our contact details above).\n\nWe appreciate your support.\n\nKind regards,")
#  second_overdue_reminder_email_subject :string(255)      default("Second Reminder - Important: Payment is overdue")
#  second_overdue_reminder_email_message :text             default("Payment for the above invoice is now overdue.\nPlease make the payment as soon as possible.\n\nPayment can be made by any of the methods listed below.\nIf you have already paid, please email or fax proof of payment to us (our contact details above).\n\nThank you.\n\nKind regards,")
#  third_overdue_reminder_email_subject  :string(255)      default("URGENT: Third and Final Reminder: Payment is now way overdue!")
#  third_overdue_reminder_email_message  :text             default("This is your third and final reminder. Payment for the above invoice is now very overdue!\nPlease make payment urgently.\n\nPayment can be made by any of the methods listed below.\nIf you have already paid, please email or fax proof of payment to us (our contact details above).\n\nIf you are not intending on paying, please give us a call or send us an email, so that we can make alternative arrangements if necessary.\n\nKind regards,")
#  final_demand_reminder_email_subject   :string(255)      default("Notice of Final Demand: Action Required")
#  final_demand_reminder_email_message   :text             default("Please understand that this is our FINAL NOTICE regarding payment for the above invoice.\nPlease make payment immediately.\n\nIf we do not receive full payment within 3 days, we will have no alternative but to hand your account over to a collection agency (Interest and collection fees will also be added to your owing amount in this case).\n\nPayment can be made by any of the methods listed below.\nIf you have already paid, please email or fax proof of payment to us (our contact details above).\n\nIf you are not intending on paying, or are unable to pay due to unforeseen circumstances, please give us a call or send us an email, so that we can make alternative arrangements if necessary.\n\nKind regards,")
#  user_id                               :integer
#  created_at                            :datetime         not null
#  updated_at                            :datetime         not null
#

class Setting < ActiveRecord::Base
  includes AttributeNormalizer

  belongs_to :user, required: true

  validates :chasing_interval, :pre_due_interval, presence: true
  validates :chasing_interval, inclusion: { in: 1..31, message: 'can only be between 0 and 31.' }
  validates :pre_due_interval, inclusion: { in: 1..31, message: 'can only be between 0 and 31.' }
end
