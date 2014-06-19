# == Schema Information
#
# Table name: invoices
#
#  id             :integer          primary key
#  invoice_number :string(255)
#  due_date       :date
#  amount         :decimal(, )
#  description    :text
#  status_id      :integer
#  client_id      :integer
#  created_at     :timestamp        not null
#  updated_at     :timestamp        not null
#  user_id        :integer
#  pd_date        :date
#  od1_date       :date
#  od2_date       :date
#  od3_date       :date
#  last_date_sent :date
#  fd_date        :date
#

class Invoice < ActiveRecord::Base
  belongs_to      :client, inverse_of: :histories
  belongs_to      :user, inverse_of: :invoices

  validates :client_id, :due_date, :invoice_number, presence: true
  validates_numericality_of :amount  

  STATUSES = {chasing: 2, stop_chasing: 3, paid: 4, send_final_demand: 5, write_off: 6, delete: 7}.freeze

  scope :chasing,  -> { where(status_id: STATUSES[:chasing]) }

  def self.search(criteria)
    if criteria
      where(arel_table[:invoice_number].matches("%#{criteria}%").or(arel_table[:description].matches("%#{criteria}%")))
    else
      scoped
    end
  end

  def age
    (Date.today - due_date.to_date).to_i
  end


  def status
    STATUSES.key(status_id)
  end
end
