class ReminderLoggerObserver
  def self.delivered_email(email)
    invoice = Invoice.find_by(invoice_number: email['X-INVOICE-ID'].value)
    invoice.touch(:last_date_sent)
    History.create! do |h|
      h.client = invoice.client
      h.invoice_number = invoice.invoice_number
      h.reminder_type = invoice.type
      h.subject = email.subject
      h.message = email.body.encoded
      h.email_sent_from = email.from
      h.copy_email = email.bcc
      h.email_sent_to = email.to
      h.email_from_name = email.from
      h.sent = true
    end
  end
end

InvoiceMailer.register_observer(ReminderLoggerObserver)