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

  to_param :invoice_number

  enum status: { chasing: 2, stop_chasing: 3, paid: 4, send_final_demand: 5, write_off: 6, deleted: 7 }

  belongs_to :client, touch: true
  belongs_to :user

  validates :client, :due_date, :invoice_number, presence: true
  validates :amount, numericality: true

  before_save :calculate_dates, if: :due_date_changed?
  before_save :set_final_demand, if: :status_changed?

  delegate :business_name, to: :client

  scope :due, -> { where('? = ANY(ARRAY[due_date, pd_date, od1_date, od2_date, od3_date, fd_date])', Date.current) }
  scope :unsent, -> { where('(last_date_sent is NULL OR last_date_sent < :now)', now: Date.current) }

  def pre_due?
    chasing? && pd_date.today? && user.setting.pre_due_reminder?
  end

  def due?
    chasing? && due_date.today? && user.setting.due_reminder?
  end

  def over_due1?
    chasing? && od1_date.today?
  end

  def over_due2?
    chasing? && od2_date.today?
  end

  def over_due3?
    chasing? && od3_date.today?
  end

  def final_demand?
    send_final_demand? && fd_date.today?
  end

  def type
    case
    when pre_due? then 'Pre'
    when due? then 'Due'
    when over_due1? then 'OD1'
    when over_due2? then 'OD2'
    when over_due3? then 'OD3'
    when final_demand? then 'FD'
    end
  end

  def age
    @age ||= (Date.current - due_date.to_date).to_i
  end

  def self.total
    sum(:amount)
  end

  protected

  def calculate_dates
    self.pd_date = due_date.days_ago(settings.days_before_pre_due)
    self.od1_date = due_date.days_since(settings.days_between_chase)
    self.od2_date = od1_date.days_since(settings.days_between_chase)
    self.od3_date = od2_date.days_since(settings.days_between_chase)
  end

  def set_final_demand
    self.fd_date = Date.current.tomorrow if send_final_demand?
  end

  def settings
    @settings ||= user.setting
  end
end
