module InvoicesHelper
  def display_age_badge(invoice)
    case
      when invoice.age > 0 then type = 'badge badge-important'
      when invoice.age == 0 then type = 'badge badge-info'
      when invoice.age < 0 then type = 'badge badge-success'
      else
       type = 'badge'
    end
    content_tag(:span, invoice.age, class: type)
  end

  def display_description(invoice)
    if invoice.description.size > 50
      content_tag(:a, truncate(invoice.description, length: 45), rel: 'popover', title: 'Invoice Description', data: { content: truncate(simple_format(invoice.description), length: 500)}) if invoice.description.size > 50
    else
      invoice.description
    end
  end

  def display_status_label(invoice)
    case invoice.status
      when :chasing then content_tag(:span, invoice.status.to_s.titleize, class: 'label label-success' )
      when :stop_chasing then content_tag(:span, invoice.status.to_s.titleize, class: 'label label-warning' )
      when :paid then content_tag(:span, invoice.status.to_s.titleize, class: 'label label-info' )
      when :send_final_demand then content_tag(:span, invoice.status.to_s.titleize, class: 'label label-important' )
      when :write_off then content_tag(:span, invoice.status.to_s.titleize, class: 'label label-inverse' )
      when :delete then content_tag(:span,  invoice.status.to_s.titleize, class: 'label label-default' )
    end
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
end
