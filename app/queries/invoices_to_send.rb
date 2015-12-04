class InvoicesToSend
  def invoices
    @invoices ||= Invoice.where(send_today.and(unsent).and(chasing_or_final_demand))
  end

  private

  def table
    @table ||= Invoice.arel_table
  end

  def unsent
    table[:last_date_sent].not_eq(today).or(table[:last_date_sent].eq(nil))
  end

  def send_today
    table[:pd_date].eq(today).
      or(table[:due_date].eq(today)).
      or(table[:od1_date].eq(today)).
      or(table[:od2_date].eq(today)).
      or(table[:od3_date].eq(today)).
      or(table[:fd_date].eq(today))
  end

  def chasing_or_final_demand
    table[:status].in([Invoice.statuses[:chasing], Invoice.statuses[:send_final_demand]])
  end

  def today
    @today ||= Date.current
  end
end
