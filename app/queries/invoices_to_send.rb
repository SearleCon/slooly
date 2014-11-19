class InvoicesToSend

  def invoices
   @invoices ||= Invoice.where(send_today.and(unsent).and(chasing_or_final_demand))
  end

  private
  def table
    Invoice.arel_table
  end

  def unsent
    table[:last_date_sent].not_eq(today)
  end

  def send_today
    pre_due.or(due).or(over_due1).or(over_due2).or(over_due3).or(final_demand)
  end

  def pre_due
    table[:pd_date].eq(today)
  end

  def due
    table[:due_date].eq(today)
  end

  def over_due1
    table[:od1_date].eq(today)
  end

  def over_due2
    table[:od2_date].eq(today)
  end

  def over_due3
    table[:od3_date].eq(today)
  end

  def final_demand
    table[:fd_date].eq(today)
  end

  def chasing_or_final_demand
    table[:status_id].in([Invoice::STATUSES[:chasing], Invoice::STATUSES[:send_final_demand]])
  end

  def today
    DateTime.now.to_date
  end

end