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

class Invoice < ActiveRecord::Base
  include CollectionCacheable

  to_param :invoice_number

  enum status: { chasing: 2, stop_chasing: 3, paid: 4, send_final_demand: 5, write_off: 6, deleted: 7 }

  belongs_to :client, touch: true
  belongs_to :user
  has_many :histories

  validates :client, :due_date, :invoice_number, presence: true
  validates :amount, numericality: true

  before_save :set_dates, if: :due_date_changed?
  before_save :set_final_demand, if: :status_changed?

  delegate :business_name, to: :client

  scope :due, -> { where('? = ANY(ARRAY[due_date, pd_date, od1_date, od2_date, od3_date, fd_date])', Date.current) }
  scope :unsent, -> { where('(last_date_sent is NULL OR last_date_sent < :now)', now: Date.current) }

  def type
    case
    when (Date.current <= pd_date) then 'Pre'
    when (pd_date..due_date).cover?(Date.current) then 'Due'
    when (due_date.next..od1_date).cover?(Date.current) then 'OD1'
    when (od1_date.next..od2_date).cover?(Date.current) then 'OD2'
    when (od2_date.next..od3_date).cover?(Date.current) then 'OD3'
    when (Date.current > od3_date) then 'FD'
    end
  end

  def age
    @age ||= (Date.current - due_date.to_date).to_i
  end

  def self.total
    sum(:amount)
  end

  protected

  def set_dates
    self.pd_date = due_date.days_ago(user.pre_due_interval)
    self.od1_date = due_date.days_since(user.chasing_interval)
    self.od2_date = od1_date.days_since(user.chasing_interval)
    self.od3_date = od2_date.days_since(user.chasing_interval)
  end

  def set_final_demand
    self.fd_date = Date.current.next if send_final_demand?
  end

end
