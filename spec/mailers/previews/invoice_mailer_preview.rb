# Preview all emails at http://localhost:3000/rails/mailers/invoice_mailer
class InvoiceMailerPreview < ActionMailer::Preview
  def reminder_email
    invoice = Invoice.includes(user: [:company, :settings]).find_by(invoice_number: History.last.invoice_number)
    InvoiceMailer.reminder_email(invoice)
  end
end
