class InvoiceDecorator < Draper::Decorator
  delegate_all

  def due_date
    l model.due_date, format: :long
  end

  def age
    h.display_age_badge(model)
  end

  def amount
    h.number_with_precision(model.amount, precision: 2)
  end

  def description
    h.content_tag(:a, h.truncate(model.description, length: 20), rel: 'popover', title: 'Invoice Description', data: { content: h.simple_format(model.description) }) if model.description.present?
  end

  def status
    h.display_status_label(model)
  end
end
