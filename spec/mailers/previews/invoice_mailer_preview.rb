# Preview all emails at http://localhost:3000/rails/mailers/reminder_mailer
class InvoiceMailerPreview < ActionMailer::Preview

  def reminder_email
    invoice = Invoice.find_by(invoice_number: History.last.invoice_number)
    invoice.due_date = Date.today
    InvoiceMailer.reminder_email(invoice)
  end
end
