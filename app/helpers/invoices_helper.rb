module InvoicesHelper
  STATUS_LABELS = { chasing: 'label label-success',
                    stop_chasing: 'label label-warning',
                    paid: 'label label-info',
                    send_final_demand: 'label label-important',
                    write_off: 'label label-inverse',
                    delete: 'label label-default' }.with_indifferent_access

  def status_label(status)
    content_tag(:span, status.titleize, class: STATUS_LABELS[status])
  end

  def age_badge(age)
    type = case
           when age.due? then 'badge badge-important'
           when age.current? then  'badge badge-info'
           when age.overdue? then  'badge badge-success'
           else 'badge'
           end
    content_tag(:span, age, class: type)
  end
end
