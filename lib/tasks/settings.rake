namespace :settings do
  desc 'Move settings over to user model'
  task relocate: :environment do
    User.transaction do
      User.includes(:setting).find_each do |user|
        if user.setting.present?
          user.reminder_email_sender_address = user.setting.send_from_name
          user.reminder_email_cc_address = user.setting.email_copy_to
          user.send_due_reminder_email = user.setting.due_reminder
          user.send_pre_due_reminder_email = user.setting.pre_due_reminder
          user.chasing_interval = user.setting.days_between_chase
          user.pre_due_interval = user.setting.days_before_pre_due
          user.payment_method_message = user.setting.payment_method_message
          user.pre_due_reminder_email_subject = user.setting.pre_due_subject
          user.pre_due_reminder_email_message = user.setting.pre_due_message
          user.due_reminder_email_subject = user.setting.due_subject
          user.due_reminder_email_message = user.setting.due_message
          user.first_overdue_reminder_email_subject = user.setting.overdue1_subject
          user.first_overdue_reminder_email_message = user.setting.overdue1_message
          user.second_overdue_reminder_email_subject = user.setting.overdue2_subject
          user.second_overdue_reminder_email_message = user.setting.overdue2_message
          user.third_overdue_reminder_email_subject = user.setting.overdue3_subject
          user.third_overdue_reminder_email_message = user.setting.overdue3_message
          user.final_demand_reminder_email_subject = user.setting.final_demand_subject
          user.final_demand_reminder_email_message = user.setting.final_demand_message

          user.save!
          puts "#{user.name} updated successfully!!!"
        end 
      end
    end
  end
end
