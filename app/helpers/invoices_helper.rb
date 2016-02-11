# == Schema Information
#
# Table name: invoices
#
#  id             :integer          not null, primary key
#  invoice_number :string(255)
#  due_date       :date
#  amount         :decimal(, )
#  description    :text
#  status         :integer          default(2)
#  client_id      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#  pd_date        :date
#  od1_date       :date
#  od2_date       :date
#  od3_date       :date
#  last_date_sent :date
#  fd_date        :date
#

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
           when age.positive? then 'label label-danger'
           when age.zero? then 'label label-info'
           when age.negative? then 'label label-success'
           else 'badge'
           end
    content_tag(:span, age, class: type)
  end
end
