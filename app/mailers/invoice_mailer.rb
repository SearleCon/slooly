class InvoiceMailer < ApplicationMailer
  def reminder_email(invoice)
    headers "X-Invoice-ID" => invoice.invoice_number


    @reminder = Invoices::Reminders.new(invoice)
    mail(from: @reminder.sender,
         to: @reminder.recipient,
         bcc: @reminder.cc,
         subject: @reminder.subject)
  end
end
