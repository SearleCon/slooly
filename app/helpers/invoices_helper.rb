module InvoicesHelper
  STATUS_LABELS = { chasing: 'label label-success',
                    stop_chasing: 'label label-warning',
                    paid: 'label label-info',
                    send_final_demand: 'label label-important',
                    write_off: 'label label-inverse',
                    delete: 'label label-default' }

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
    return unless invoice.description.present?
    if invoice.description.size > 20
      content_tag(:a, truncate(invoice.description, length: 20), rel: 'popover', title: 'Invoice Description', data: { content: simple_format(invoice.description) })
    else
      invoice.description
    end
  end

  def display_status_label(invoice)
    content_tag(:span, invoice.status.to_s.titleize, class: STATUS_LABELS[invoice.status])
  end

  def confirm_delete_invoice_message(invoice)
    simple_format("<span class='label label-important'>WARNING!</span><br>
                   You are about to delete the invoice <b> #{invoice.invoice_number}!</b><br>
                   <b>NOTE:</b> This cannot be undone!<br>
                   Are you sure you want to continue?", {}, sanitize: false)
  end

  def options_for_status
    Invoice::STATUSES.transform_keys { |key| key.to_s.titleize }
  end

  def status
    Invoice::STATUSES.sort.transform_keys { |key| key.to_s.titleize }
  end
end
