# == Schema Information
#
# Table name: settings
#
#  id                     :integer          not null, primary key
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
#  created_at             :datetime
#  updated_at             :datetime
#

class Setting < ActiveRecord::Base
  belongs_to :user, touch: true

  validates :days_between_chase, :days_before_pre_due, presence: true
  validates :days_between_chase, inclusion: { in: 1..31, message: 'can only be between 0 and 31.' }
  validates :days_before_pre_due, inclusion: { in: 1..31, message: 'can only be between 0 and 31.' }

  after_initialize :set_defaults, if: :new_record?
  before_save :strip_messages

  protected

  def set_defaults
    self.send_from_name = 'Your Business'
    self.email_copy_to = 'copy@example.com'
    self.days_between_chase = 7
    self.days_before_pre_due = 2
    self.payment_method_message = %(Deposit or Transfer to:
                                    Bank:
                                    Account:
                                    Account Type:
                                    Branch Code:)
    self.pre_due_reminder = true
    self.pre_due_subject = 'Friendly Reminder: Payment due soon'
    self.pre_due_message = %(This is a friendly reminder that payment for the above invoice is due in a couple of days time.\n
                             We really do appreciate your timely payment.
                             Payment can be made by any of the methods listed below.\n
                             We appreciate your support and value you as our customer.\n
                             Kind regards,)

    self.due_reminder = true
    self.due_subject = 'Payment Due Today'
    self.due_message = %(This is a friendly reminder that payment for the above invoice is due today.\n
                         We really do appreciate your timely payment.
                         Payment can be made by any of the methods listed below.\n
                         If you have already paid, please ignore this email.\n
                         We appreciate your support.\n
                         Kind regards,)

    self.overdue1_subject = 'Important Reminder: Payment overdue'
    self.overdue1_message = %(Please note that payment for the above invoice is now overdue.\n
                              We really do appreciate your business and timeous payment.
                              Payment can be made by any of the methods listed below.\n
                              If you have already paid, please email or fax proof of payment to us (our contact details above).
                              We appreciate your support.\n
                              Kind regards,)

    self.overdue2_subject = 'Second Reminder - Important: Payment is overdue'
    self.overdue2_message = %(Payment for the above invoice is now overdue.\n
                              Please make the payment as soon as possible.
                              Payment can be made by any of the methods listed below.\n
                              If you have already paid, please email or fax proof of payment to us (our contact details above).\n
                              Thank you.\n
                              Kind regards,)

    self.overdue3_subject = 'URGENT: Third and Final Reminder: Payment is now way overdue!'
    self.overdue3_message = %(This is your third and final reminder. Payment for the above invoice is now very overdue!\n
                              Please make payment urgently.
                              Payment can be made by any of the methods listed below.\n
                              If you have already paid, please email or fax proof of payment to us (our contact details above).
                              If you are not intending on paying, please give us a call or send us an email, so that we can make alternative arrangements if necessary.\n
                              Kind regards,)

    self.final_demand_subject = 'Notice of Final Demand: Action Required'
    self.final_demand_message = %(Please understand that this is our FINAL NOTICE regarding payment for the above invoice.\n
                                  Please make payment immediately.
                                  If we do not receive full payment within 3 days, we will have no alternative but to hand your account over to a collection agency (Interest and collection fees will also be added to your owing amount in this case).
                                  Payment can be made by any of the methods listed below.\n
                                  If you have already paid, please email or fax proof of payment to us (our contact details above).
                                  If you are not intending on paying, or are unable to pay due to unforeseen circumstances, please give us a call or send us an email, so that we can make alternative arrangements if necessary.\n
                                  Kind regards,)
  end

  def strip_messages
    payment_method_message.strip!
    pre_due_message.strip!
    due_message.strip!
    overdue1_message.strip!
    overdue2_message.strip!
    overdue3_message.strip!
    final_demand_message.strip!
  end
end
