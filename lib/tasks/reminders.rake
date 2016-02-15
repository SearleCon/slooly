namespace :reminders do
  desc 'Sends reminder emails which are due'
  task send: :environment do
     SendReminders.perform 
  end
end
