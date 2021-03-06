class InvoiceMailer < ApplicationMailer
  after_action :log_reminder

  def reminder_email(invoice)
    @invoice = invoice
    @client = invoice.client
    @user = invoice.user
    @company = @user.company
    @reminder = Invoices::Reminders.new(invoice)
    mail(from: @company.email,
         to: @client.email,
         bcc: @user.reminder_email_cc_address,
         subject: @reminder.subject)
  end

  private

  def log_reminder
      @invoice.last_date_sent = Date.current
      @invoice.histories.build do |history|
        history.date_sent = Date.current 
        history.invoice_number = @invoice.invoice_number
        history.reminder_type = @invoice.type
        history.subject = mail.subject
        history.message = mail.body.encoded
        history.email_sent_from = mail.from
        history.copy_email = mail.bcc
        history.email_sent_to = mail.to
        history.email_from_name = mail.from
        history.sent = true
      end
      @invoice.save
  end
end
