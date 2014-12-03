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

  STATUSES = { chasing: 2, stop_chasing: 3, paid: 4, send_final_demand: 5, write_off: 6, delete: 7 }.freeze

  belongs_to :client, touch: true
  belongs_to :user, touch: true

  validates :client, :due_date, :invoice_number, presence: true
  validates :amount, numericality: true

  scope :chasing, -> { where(status_id: STATUSES[:chasing]) }

  delegate :business_name, to: :client, prefix: true

  after_initialize :setup_defaults, if: :new_record?
  before_save :calculate_dates, if: :due_date_changed?

  def age
    @age ||= Invoice::Age.from_due_date(due_date)
  end

  def status
    STATUSES.key(status_id)
  end

  def status?(value)
   status == value
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

  def calculate_dates
    calculator = Invoice::DateCalculator.new(self)
    self.pd_date = calculator.pre_due
    self.od1_date = calculator.over_due1
    self.od2_date = calculator.over_due2
    self.od3_date = calculator.over_due3
    self.last_date_sent = calculator.last_date_sent
    self.fd_date = calculator.final_demand if status == :send_final_demand
  end
end
