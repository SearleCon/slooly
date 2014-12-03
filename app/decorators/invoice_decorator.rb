class InvoiceDecorator < Draper::Decorator
  delegate_all

  def age
    h.display_age_badge(model)
  end

  def amount
    h.number_with_precision(model.amount, precision: 2)
  end

  def description
    h.display_description(model)
  end

  def status
    h.display_status_label(model)
  end
end
