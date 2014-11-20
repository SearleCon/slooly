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
  STATUSES = { chasing: 2, stop_chasing: 3, paid: 4, send_final_demand: 5, write_off: 6, delete: 7 }.freeze

  self.per_page = 10

  belongs_to :client, inverse_of: :histories, touch: true
  belongs_to :user, inverse_of: :invoices, touch: true

  validates :client, :due_date, :invoice_number, presence: true
  validates :amount, numericality: true

  scope :chasing, -> { where(status_id: STATUSES[:chasing]) }

  delegate :business_name, to: :client, prefix: true

  after_initialize :setup_defaults, if: :new_record?

  def age
    (Date.today - due_date.to_date).to_i
  end

  def status
    STATUSES.key(status_id)
  end

  def pre_due?
    pd_date == DateTime.now.to_date
  end

  def due?
    due_date == DateTime.now.to_date
  end

  def over_due1?
    od1_date == DateTime.now.to_date
  end

  def over_due2?
    od2_date == DateTime.now.to_date
  end

  def over_due3?
    od3_date == DateTime.now.to_date
  end

  def final_demand?
    fd_date == DateTime.now.to_date
  end

  def self.total
    sum(:amount)
  end

  private

  def setup_defaults
    self.last_date_sent = Date.today - 1.year
  end
end
