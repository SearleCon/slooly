# == Schema Information
#
# Table name: invoices
#
#  id             :integer          not null, primary key
#  invoice_number :string(255)
#  due_date       :date
#  amount         :decimal(, )
#  description    :text
#  status         :integer
#  client_id      :integer
#  created_at     :datetime
#  updated_at     :datetime
#  user_id        :integer
#  pd_date        :date
#  od1_date       :date
#  od2_date       :date
#  od3_date       :date
#  last_date_sent :date
#  fd_date        :date
#

class Invoice < ActiveRecord::Base
  to_param :invoice_number

  OVERDUE2_MODIFIER = 2
  OVERDUE3_MODIFIER = 3
  FINAL_DEMAND_PERIOD = 1

  enum status: { chasing: 2, stop_chasing: 3, paid: 4, send_final_demand: 5, write_off: 6, deleted: 7 }

  belongs_to :client, touch: true
  belongs_to :user

  validates :client, :due_date, :invoice_number, presence: true
  validates :amount, numericality: true

  after_initialize :set_defaults, if: :new_record?
  before_save :calculate_dates, if: :due_date_changed?
  before_save :set_final_demand, if: :status_changed?

  delegate :business_name, to: :client

  scope :search, ->(query) { where('description ILIKE :query or invoice_number ILIKE :query', query: "%#{query}%") }

  def pre_due?
    pd_date.today?
  end

  def due?
    due_date.today?
  end

  def over_due1?
    od1_date.today?
  end

  def over_due2?
    od2_date.today?
  end

  def over_due3?
    od3_date.today?
  end

  def final_demand?
    fd_date.today?
  end

  def age
    @age ||= Invoice::Age.from_due_date(due_date)
  end

  def self.total
    sum(:amount)
  end

  protected

  def set_defaults
    self.status ||= :chasing
  end

  def calculate_dates
    self.pd_date = days_before_pre_due.days.ago
    self.od1_date = days_between_chase.days.from_now
    self.od2_date = (days_between_chase * OVERDUE2_MODIFIER).days.from_now
    self.od3_date = (days_between_chase * OVERDUE3_MODIFIER).days.from_now
  end

  def set_final_demand
    self.fd_date = FINAL_DEMAND_PERIOD.days.from_now if send_final_demand?
  end

  def days_between_chase
    user.setting.days_between_chase
  end

  def days_before_pre_due
    user.setting.days_before_pre_due
  end
end
