namespace :reminders do
  desc 'Sends reminder emails which are due'
  task send: :environment do

    invoices = InvoicesToSend.new.invoices

    reminders_to_send = invoices.map { |invoice| Invoices::Reminders.new(invoice) }.select(&:send?)

    reminders_to_send.each do |reminder|
      history = History.create do |h|
        h.client = reminder.invoice.client
        h.invoice_number = reminder.invoice.invoice_number
        h.subject = reminder.subject
        h.message = reminder.text
        h.reminder_type = reminder.type
        h.email_sent_from = reminder.sender
        h.copy_email = reminder.cc
        h.email_sent_to = reminder.recipient
        h.email_from_name = reminder.sender_name
      end
      SendRemindersJob.perform_later(reminder.invoice, history)
    end
  end
end
