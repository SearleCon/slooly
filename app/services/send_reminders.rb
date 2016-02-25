class SendReminders
  include Service

  def perform
    invoices.find_each { |invoice| InvoiceMailer.reminder_email(invoice).deliver_later }
  end

  private

  def invoices
    @invoices ||= Invoice.includes(user: [:company, :settings]).due.unsent.where(status: [Invoice.statuses[:chasing], Invoice.statuses[:send_final_demand]])
  end

end
