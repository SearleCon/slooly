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
  self.per_page = 10

  belongs_to      :client, inverse_of: :histories, touch: true
  belongs_to      :user, inverse_of: :invoices, touch: true

  validates :client, :due_date, :invoice_number, presence: true
  validates_numericality_of :amount  

  STATUSES = {chasing: 2, stop_chasing: 3, paid: 4, send_final_demand: 5, write_off: 6, delete: 7}.freeze

  scope :chasing,  -> { where(status_id: STATUSES[:chasing]) }

  def age
    (Date.today - due_date.to_date).to_i
  end

  def self.total
    sum(:amount)
  end


  def status
    STATUSES.key(status_id)
  end
end
