# SHAUN! This is where you put in details for running of background tasks
# Run these methods in the background by typing this in the terminal: "rake send_reminders" (it will then run the second task in this file reminder!)
# Any files stores in the LIB folder can be called.
# And the same files can be run in Heroku by calling: "heroku run rake send_reminders"
# You can use the Heroku Scheduler add on to run these kind of jobs automatically, daily, hourly or every 10 minutes (They count towards your dyno hours though!)
# Check out https://devcenter.heroku.com/articles/scheduler for more information on scheduling
# rake tasks:run
# rake jobs:work

# SS NOTE:
# These are the three things that need to run in order to get the emails sending:
# 1. "rake send_reminders" - This is your rake task in the actual rake file (lib directory - i.e. THIS file (See the task below))
# 2. "rake jobs:work" - On heroku can be run too. Needs to be running to process delayed jobs
# 3. Your server must be running

task send_reminders: :environment do

  invoices = InvoicesToSend.new.invoices

  reminders_to_send = invoices.map {|i| Invoice::Reminders.new(i) }.select(&:send?)

  reminders_to_send.each do |reminder|
     history = History.create do |history|
        history.client = reminder.invoice.client
        history.user = reminder.invoice.user
        history.invoice_number = reminder.invoice.invoice_number
        history.subject = reminder.subject
        history.message = reminder.text
        history.reminder_type = reminder.type
        history.email_sent_from = reminder.sender
        history.copy_email = reminder.cc
        history.email_sent_to = reminder.recipient
        history.email_from_name = reminder.sender_name
     end
     SendRemindersJob.perform_later(reminder.invoice, history)
  end
end
