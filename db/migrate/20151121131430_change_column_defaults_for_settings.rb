class ChangeColumnDefaultsForSettings < ActiveRecord::Migration
  def change
    change_column_default :settings, :send_from_name, 'Your Business'
    change_column_default :settings, :email_copy_to, 'copy@example.com'
    change_column_default :settings, :days_between_chase, 7
    change_column_default :settings, :days_before_pre_due, 2
    change_column_default :settings, :payment_method_message, "(Deposit or Transfer to:\nBank:\nAccount:\nAccount Type:\nBranch Code:)"
    change_column_default :settings, :pre_due_reminder, true
    change_column_default :settings, :pre_due_subject, 'Friendly Reminder: Payment due soon'
    change_column_default :settings, :pre_due_message, "This is a friendly reminder that payment for the above invoice is due in a couple of days time.\nWe really do appreciate your timely payment.\n\nPayment can be made by any of the methods listed below.\n\nWe appreciate your support and value you as our customer.\n\nKind regards,"
    change_column_default :settings, :due_reminder, true
    change_column_default :settings, :due_subject, 'Payment Due Today'
    change_column_default :settings, :due_message, "This is a friendly reminder that payment for the above invoice is due today.\nWe really do appreciate your timely payment.\n\nPayment can be made by any of the methods listed below.\nIf you have already paid, please ignore this email.\n\nWe appreciate your support.\n\nKind regards,"
    change_column_default :settings, :overdue1_subject, 'Important Reminder: Payment overdue'
    change_column_default :settings, :overdue1_message, "Please note that payment for the above invoice is now overdue.\nWe really do appreciate your business and timeous payment.\n\nPayment can be made by any of the methods listed below.\nIf you have already paid, please email or fax proof of payment to us (our contact details above).\n\nWe appreciate your support.\n\nKind regards,"
    change_column_default :settings, :overdue2_subject, 'Second Reminder - Important: Payment is overdue'
    change_column_default :settings, :overdue2_message, "Payment for the above invoice is now overdue.\nPlease make the payment as soon as possible.\n\nPayment can be made by any of the methods listed below.\nIf you have already paid, please email or fax proof of payment to us (our contact details above).\n\nThank you.\n\nKind regards,"
    change_column_default :settings, :overdue3_subject, 'URGENT: Third and Final Reminder: Payment is now way overdue!'
    change_column_default :settings, :overdue3_message, "This is your third and final reminder. Payment for the above invoice is now very overdue!\nPlease make payment urgently.\n\nPayment can be made by any of the methods listed below.\nIf you have already paid, please email or fax proof of payment to us (our contact details above).\n\nIf you are not intending on paying, please give us a call or send us an email, so that we can make alternative arrangements if necessary.\n\nKind regards,"
    change_column_default :settings, :final_demand_subject, 'Notice of Final Demand: Action Required'
    change_column_default :settings, :final_demand_message, "Please understand that this is our FINAL NOTICE regarding payment for the above invoice.\nPlease make payment immediately.\n\nIf we do not receive full payment within 3 days, we will have no alternative but to hand your account over to a collection agency (Interest and collection fees will also be added to your owing amount in this case).\n\nPayment can be made by any of the methods listed below.\nIf you have already paid, please email or fax proof of payment to us (our contact details above).\n\nIf you are not intending on paying, or are unable to pay due to unforeseen circumstances, please give us a call or send us an email, so that we can make alternative arrangements if necessary.\n\nKind regards,"

  end


end
