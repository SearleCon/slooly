class AddSettingsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :settings, :jsonb, default: '{ "reminder_email_sender_address": "Your Business",
                                                      "reminder_email_cc_address": 1,
                                                      "send_due_reminder_email": true,
                                                      "send_pre_due_reminder_email": true,
                                                      "chasing_interval": 7,
                                                      "pre_due_interval": 2,
                                                      "payment_method_message": "(Deposit or Transfer to:\nBank:\nAccount:\nAccount Type:\nBranch Code:)",
                                                      "pre_due_reminder_email_subject": "Friendly Reminder: Payment due soon",
                                                      "pre_due_reminder_email_message":  "This is a friendly reminder that payment for the above invoice is due in a couple of days time.\nWe really do appreciate your timely payment.\n\nPayment can be made by any of the methods listed below.\n\nWe appreciate your support and value you as our customer.\n\nKind regards,",
                                                      "due_reminder_email_subject": "Payment Due Today",
                                                      "due_reminder_email_message": "This is a friendly reminder that payment for the above invoice is due today.\nWe really do appreciate your timely payment.\n\nPayment can be made by any of the methods listed below.\nIf you have already paid, please ignore this email.\n\nWe appreciate your support.\n\nKind regards,",
                                                      "first_overdue_reminder_email_subject": "Important Reminder: Payment overdue",
                                                      "first_overdue_reminder_email_message": "Please note that payment for the above invoice is now overdue.\nWe really do appreciate your business and timeous payment.\n\nPayment can be made by any of the methods listed below.\nIf you have already paid, please email or fax proof of payment to us (our contact details above).\n\nWe appreciate your support.\n\nKind regards,",
                                                      "second_overdue_reminder_email_subject": "Second Reminder - Important: Payment is overdue",
                                                      "second_overdue_reminder_email_message": "Payment for the above invoice is now overdue.\nPlease make the payment as soon as possible.\n\nPayment can be made by any of the methods listed below.\nIf you have already paid, please email or fax proof of payment to us (our contact details above).\n\nThank you.\n\nKind regards,",
                                                      "third_overdue_reminder_email_subject": "URGENT: Third and Final Reminder: Payment is now way overdue!",
                                                      "third_overdue_reminder_email_message": "This is your third and final reminder. Payment for the above invoice is now very overdue!\nPlease make payment urgently.\n\nPayment can be made by any of the methods listed below.\nIf you have already paid, please email or fax proof of payment to us (our contact details above).\n\nIf you are not intending on paying, please give us a call or send us an email, so that we can make alternative arrangements if necessary.\n\nKind regards,",
                                                      "final_demand_reminder_email_subject": "Notice of Final Demand: Action Required",
                                                      "final_demand_reminder_email_message": "Please understand that this is our FINAL NOTICE regarding payment for the above invoice.\nPlease make payment immediately.\n\nIf we do not receive full payment within 3 days, we will have no alternative but to hand your account over to a collection agency (Interest and collection fees will also be added to your owing amount in this case).\n\nPayment can be made by any of the methods listed below.\nIf you have already paid, please email or fax proof of payment to us (our contact details above).\n\nIf you are not intending on paying, or are unable to pay due to unforeseen circumstances, please give us a call or send us an email, so that we can make alternative arrangements if necessary.\n\nKind regards,"
                                                    }'

    add_index  :users, :settings, using: :gin
  end
end
