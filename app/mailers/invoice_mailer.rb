class InvoiceMailer < ApplicationMailer
  def reminder_email(invoice)
    @invoice = invoice
    @client = invoice.client
    @settings = invoice.user.setting
    @company = invoice.user.company
    @reminder = Invoices::Reminders.new(invoice)
    mail(to: 'jim@example.com')
  end
end
