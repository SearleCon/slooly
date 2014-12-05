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
  include Invoice::StatusExtension
  include Invoice::RemindersExtension

  self.per_page = 10

  belongs_to :client, touch: true
  belongs_to :user, touch: true

  validates :client, :due_date, :invoice_number, presence: true
  validates :amount, numericality: true

  delegate :business_name, to: :client, prefix: true

  def age
    @age ||= Invoice::Age.from_due_date(due_date)
  end

  def self.total
    sum(:amount)
  end
end
