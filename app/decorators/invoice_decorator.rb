class InvoiceDecorator < Draper::Decorator
  STATUS_LABELS = { chasing: 'label label-success',
                    stop_chasing: 'label label-warning',
                    paid: 'label label-info',
                    send_final_demand: 'label label-important',
                    write_off: 'label label-inverse',
                    delete: 'label label-default' }.with_indifferent_access

  delegate_all

  def created_at
    h.local_time_ago(model.created_at)
  end

  def due_date
    l model.due_date, format: :long
  end

  def age
    age_badge
  end

  def amount
    h.number_with_precision(model.amount, precision: 2)
  end

  def description
    h.content_tag(:a, h.truncate(model.description, length: 20), rel: 'popover', title: 'Invoice Description', data: { content: h.simple_format(model.description), trigger: 'hover', animation: true })
  end

  def status
    h.content_tag(:span, model.status.titleize, class: STATUS_LABELS[model.status])
  end

  private

  def age_badge
    type = case
             when model.age.due? then  'badge badge-important'
             when model.age.current? then  'badge badge-info'
             when model.age.overdue? then  'badge badge-success'
             else 'badge'
           end
    h.content_tag(:span, model.age, class: type)
  end
end
