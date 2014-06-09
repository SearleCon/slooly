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
  attr_accessible :amount, :client_id, :description, :due_date, :invoice_number, :status_id
  belongs_to      :client
  belongs_to      :user

  validates       :client_id, :due_date, :invoice_number, :presence => true
  validates_numericality_of :amount  

  STATUSES = {chasing: 2, stop_chasing: 3, paid: 4, send_final_demand: 5, write_off: 6, delete: 7}.freeze

  scope :chasing,  -> { where(status_id: STATUSES[:chasing]) }

  
#  delegate :business_name, :to => :client, :prefix => true


  def self.invoice
    self.arel_table
  end
  private_class_method :invoice

  def self.for_user(user) 
      where("user_id = ?", user)
  end

  def self.for_client(client) 
      where("client_id = ?", client)
  end
  
  def self.search(criteria)
    if criteria
      where(invoice[:invoice_number].matches("%#{criteria}%").or(invoice[:description].matches("%#{criteria}%")))
    else
      scoped
    end
  end
  
  def self.invoice_for_user_with_status(user_id, status_id)
    Invoice.find(:all, :conditions => ["user_id = ? and status_id = ?", user_id, status_id])
  end
  
  def self.status_description(status_id)
    status_descriptions = Status.all :conditions => ["id = ?", status_id]
    status_descriptions[0].description
  end
  
  def self.age(due_date)
    age = (Date.today - due_date.to_date).to_i
  end

  def age
    (Date.today - due_date.to_date).to_i
  end
  
  def self.for_user_and_status(client_id, status_id) 
    @clients_invoices_chasing = Invoice.all :conditions => ["client_id = ? and status_id = ?", client_id, status_id], :order => "due_date asc"
  end

  def status
    STATUSES.key(status_id)
  end
end
