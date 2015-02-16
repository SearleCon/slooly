class SendRemindersJob < Struct.new(:invoice_id, :history_id)
  def perform
    UserMailer.send_it(history).deliver
  end

  def success(_job)
    mark_history_as_sent!
    set_invoice_last_date_sent!
  end

  private

  def history
    @history ||= History.find(history_id)
  end

  def invoice
    @invoice ||= Invoice.find(invoice_id)
  end

  def mark_history_as_sent!
    history.update!(sent: true)
  end

  def set_invoice_last_date_sent!
    invoice.update!(last_date_sent: Date.current)
  end
end
