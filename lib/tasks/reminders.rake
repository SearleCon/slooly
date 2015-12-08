namespace :reminders do
  desc 'Sends reminder emails which are due'
  task send: :environment do
    invoices = Invoice.due_on(Date.current).unsent.where(status: [Invoice.statuses[:chasing], Invoice.statuses[:send_final_demand]])
    reminders = invoices.map { |invoice| Invoices::Reminders.new(invoice) }.select(&:send?)
    InvoiceMailer.reminder_email(reminder.invoice).deliver_later
  end
end
