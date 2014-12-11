module InvoicesHelper
  LABELS_FOR_STATUS = { chasing: 'label label-success',
                        stop_chasing: 'label label-warning',
                        paid: 'label label-info',
                        send_final_demand: 'label label-important',
                        write_off: 'label label-inverse',
                        delete: 'label label-default' }.with_indifferent_access

  def display_age_badge(invoice)
    case
      when invoice.age.due? then type = 'badge badge-important'
      when invoice.age.current? then type = 'badge badge-info'
      when invoice.age.overdue? then type = 'badge badge-success'
      else type = 'badge'
    end
    content_tag(:span, invoice.age, class: type)
  end

  def display_description(invoice)
    if invoice.description.present?
      content_tag(:a, truncate(invoice.description, length: 20), rel: 'popover', title: 'Invoice Description', data: { content: simple_format(invoice.description) })
    end
  end

  def display_status_label(invoice)
    content_tag(:span, invoice.status.titleize, class: LABELS_FOR_STATUS[invoice.status])
  end

  def options_for_status
    Invoice.statuses.keys
  end
end
