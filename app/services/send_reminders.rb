class SendReminders
  include Service

  def perform
    invoices.find_each do  |invoice|
      if invoice.pre_due? || invoice.due? || invoice.over_due1? || invoice.over_due2? || invoice.over_due3? || invoice.final_demand?
        InvoiceMailer.reminder_email(invoice).deliver_later 
      end
    end
  end

  private

  def invoices
    @invoices ||= Invoice.due.unsent.where(status: [Invoice.statuses[:chasing], Invoice.statuses[:send_final_demand]])
  end


end
