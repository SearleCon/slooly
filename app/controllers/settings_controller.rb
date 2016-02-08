# == Schema Information
#
# Table name: settings
#
#  id                     :integer          not null, primary key
#  send_from_name         :string(255)      default("Your Business")
#  email_copy_to          :string(255)      default("copy@example.com")
#  days_between_chase     :integer          default(7)
#  days_before_pre_due    :integer          default(2)
#  payment_method_message :text             default("(Deposit or Transfer to:\nBank:\nAccount:\nAccount Type:\nBranch Code:)")
#  pre_due_reminder       :boolean          default(TRUE)
#  pre_due_subject        :string(255)      default("Friendly Reminder: Payment due soon")
#  pre_due_message        :text             default("This is a friendly reminder that payment for the above invoice is due in a couple of days time.\nWe really do appreciate your timely payment.\n\nPayment can be made by any of the methods listed below.\n\nWe appreciate your support and value you as our customer.\n\nKind regards,")
#  due_reminder           :boolean          default(TRUE)
#  due_subject            :string(255)      default("Payment Due Today")
#  due_message            :text             default("This is a friendly reminder that payment for the above invoice is due today.\nWe really do appreciate your timely payment.\n\nPayment can be made by any of the methods listed below.\nIf you have already paid, please ignore this email.\n\nWe appreciate your support.\n\nKind regards,")
#  overdue1_subject       :string(255)      default("Important Reminder: Payment overdue")
#  overdue1_message       :text             default("Please note that payment for the above invoice is now overdue.\nWe really do appreciate your business and timeous payment.\n\nPayment can be made by any of the methods listed below.\nIf you have already paid, please email or fax proof of payment to us (our contact details above).\n\nWe appreciate your support.\n\nKind regards,")
#  overdue2_subject       :string(255)      default("Second Reminder - Important: Payment is overdue")
#  overdue2_message       :text             default("Payment for the above invoice is now overdue.\nPlease make the payment as soon as possible.\n\nPayment can be made by any of the methods listed below.\nIf you have already paid, please email or fax proof of payment to us (our contact details above).\n\nThank you.\n\nKind regards,")
#  overdue3_subject       :string(255)      default("URGENT: Third and Final Reminder: Payment is now way overdue!")
#  overdue3_message       :text             default("This is your third and final reminder. Payment for the above invoice is now very overdue!\nPlease make payment urgently.\n\nPayment can be made by any of the methods listed below.\nIf you have already paid, please email or fax proof of payment to us (our contact details above).\n\nIf you are not intending on paying, please give us a call or send us an email, so that we can make alternative arrangements if necessary.\n\nKind regards,")
#  final_demand_subject   :string(255)      default("Notice of Final Demand: Action Required")
#  final_demand_message   :text             default("Please understand that this is our FINAL NOTICE regarding payment for the above invoice.\nPlease make payment immediately.\n\nIf we do not receive full payment within 3 days, we will have no alternative but to hand your account over to a collection agency (Interest and collection fees will also be added to your owing amount in this case).\n\nPayment can be made by any of the methods listed below.\nIf you have already paid, please email or fax proof of payment to us (our contact details above).\n\nIf you are not intending on paying, or are unable to pay due to unforeseen circumstances, please give us a call or send us an email, so that we can make alternative arrangements if necessary.\n\nKind regards,")
#  user_id                :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class SettingsController < ApplicationController
  before_action :authenticate_user!, :authorize_user!

  before_action :set_settings

  def update
    @settings.update(settings_params)
    respond_with @settings, location: settings_url
  end

  private

  def set_settings
    @settings = Setting.find_by(user_id: current_user.id)
  end

  def settings_params
    params.require(:setting).permit(:days_before_pre_due, :days_between_chase, :due_message,
                                    :due_reminder, :due_subject, :email_copy_to,
                                    :final_demand_message, :final_demand_subject, :overdue1_message,
                                    :overdue1_subject, :overdue2_message, :overdue2_subject, :overdue3_message,
                                    :overdue3_subject, :payment_method_message, :pre_due_message,
                                    :pre_due_reminder, :pre_due_subject, :send_from_name)
  end
end
