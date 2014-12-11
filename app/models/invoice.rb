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
  enum status: { chasing: 2, stop_chasing: 3, paid: 4, send_final_demand: 5, write_off: 6, deleted: 7 }

  belongs_to :client, touch: true
  belongs_to :user, touch: true

  validates :client, :due_date, :invoice_number, presence: true
  validates :amount, numericality: true

  after_initialize :set_defaults, if: :new_record?
  before_save :calculate_dates, if: :due_date_changed?
  before_save :set_final_demand, if: :status_changed?


  delegate :business_name, to: :client, prefix: true

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

  def age
    @age ||= Invoice::Age.from_due_date(due_date)
  end

  def self.total
    sum(:amount)
  end

  protected

  def set_defaults
    self.status = :chasing
  end

  def calculate_dates
    self.pd_date = due_date.days_ago(user.setting.days_before_pre_due)
    self.od1_date = due_date.days_since(user.setting.days_between_chase)
    self.od2_date = due_date.days_since(user.setting.days_between_chase * 2)
    self.od3_date = due_date.days_since(user.setting.days_between_chase * 3)
  end

  def set_final_demand
    self.fd_date = Date.today.days_since(1) if send_final_demand?
  end
end
