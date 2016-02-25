class RenameSettingsColumns < ActiveRecord::Migration
  def change
    rename_column :settings, :send_from_name, :reminder_email_sender_address
    rename_column :settings, :email_copy_to, :reminder_email_cc_address
    rename_column :settings, :days_between_chase, :chasing_interval
    rename_column :settings, :days_before_pre_due, :pre_due_interval
    rename_column :settings, :pre_due_reminder, :send_pre_due_reminder_email
    rename_column :settings, :due_reminder, :send_due_reminder_email
    rename_column :settings, :pre_due_subject, :pre_due_reminder_email_subject
    rename_column :settings, :pre_due_message, :pre_due_reminder_email_message
    rename_column :settings, :due_subject, :due_reminder_email_subject
    rename_column :settings, :due_message, :due_reminder_email_message
    rename_column :settings, :overdue1_subject, :first_overdue_reminder_email_subject
    rename_column :settings, :overdue1_message, :first_overdue_reminder_email_message
    rename_column :settings, :overdue2_subject, :second_overdue_reminder_email_subject
    rename_column :settings, :overdue2_message, :second_overdue_reminder_email_message
    rename_column :settings, :overdue3_subject, :third_overdue_reminder_email_subject
    rename_column :settings, :overdue3_message, :third_overdue_reminder_email_message
    rename_column :settings, :final_demand_subject, :final_demand_reminder_email_subject
    rename_column :settings, :final_demand_message, :final_demand_reminder_email_message
  end
end
