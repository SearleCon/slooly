class SummaryReport
  attr_reader :over_ninety_days, :sixty_to_ninety_days, :thirty_to_sixty_days, :zero_to_thirty_days, :not_due, :total

  def initialize(invoices)
    @invoices = invoices
  end

  def over_ninety_days
    @over_ninety_days ||=  @invoices.select { |invoice| invoice.age > 90 }.sum(&:amount)
  end

  def sixty_to_ninety_days
    @sixty_to_ninety_days ||=  @invoices.select { |invoice| invoice.age.between?(61, 90) }.sum(&:amount)
  end

  def thirty_to_sixty_days
    @thirty_to_sixty_days ||=  @invoices.select { |invoice| invoice.age.between?(31, 60) }.sum(&:amount)
  end

  def zero_to_thirty_days
    @zero_to_thirty_days ||=  @invoices.select { |invoice| invoice.age.between?(0, 30) }.sum(&:amount)
  end

  def not_due
   @not_due ||=  @invoices.select { |invoice| invoice.age < 0 }.sum(&:amount)
  end

  def total
    @total ||= over_ninety_days + sixty_to_ninety_days + thirty_to_sixty_days + zero_to_thirty_days + not_due
  end
end
