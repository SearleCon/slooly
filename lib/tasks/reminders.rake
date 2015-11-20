namespace :reminders do
  desc 'Sends reminder emails which are due'
  task send: :environment do

    invoices = InvoicesToSend.new.invoices

    reminders_to_send = invoices.map {|invoice| Invoice::Reminders.new(invoice) }.select(&:send?)

    reminders_to_send.each do |reminder|
       history = History.create do |history|
          history.client = reminder.invoice.client
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
end
