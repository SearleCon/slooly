class InvoiceDates

  attr_reader :pre_due, :over_due1, :over_due2, :over_due3, :last_date_sent, :final_demand
  def initialize(invoice, settings)
    @invoice = invoice
    @settings = settings
  end

  def pre_due
    @invoice.due_date - pre_due_days
  end

  def over_due1
    @invoice.due_date + od1_days
  end

  def over_due2
    @invoice.due_date + od2_days
  end

  def over_due3
    @invoice.due_date + od3_days
  end

  def last_date_sent
    DateTime.now - 100.years
  end

  def final_demand
    Date.today + 1.day
  end

  private
   def pre_due_days
     @settings.days_before_pre_due.days
   end

   def od1_days
     @settings.days_between_chase.days
   end

   def od2_days
     (@settings.days_between_chase * 2).days
   end

   def od3_days
     (@settings.days_between_chase * 3).days
   end

end