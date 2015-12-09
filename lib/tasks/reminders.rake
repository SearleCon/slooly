namespace :reminders do
  desc 'Sends reminder emails which are due'
  task send: :environment do
    invoices = Invoice.due_on(Date.current).unsent.where(status: [Invoice.statuses[:chasing], Invoice.statuses[:send_final_demand]])
    invoices.each do |invoice|
      if invoice.pre_due? || invoice.due? || invoice.over_due1?  || invoice.over_due2? || invoice.over_due3? || invoice.final_demand?
       InvoiceMailer.reminder_email(invoice).deliver_later
      end
    end
  end
end
