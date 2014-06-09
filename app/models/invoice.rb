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
  before_save :setup_chase_dates
  

  
#  delegate :business_name, :to => :client, :prefix => true
  
  def self.status_description(status_id)
    Status.find(:all, :conditions => ["where id = ?", status_id]) 
  end
  
  def self.for_user(user) 
      where("user_id = ?", user)
  end  

  def self.for_client(client) 
      where("client_id = ?", client)
  end
  
  def self.search(search)
    if search
      where('LOWER(invoice_number) LIKE ? or LOWER(description) LIKE ?', "%#{search}%".downcase, "%#{search}%".downcase)
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
  
  def self.for_user_and_status(client_id, status_id) 
    @clients_invoices_chasing = Invoice.all :conditions => ["client_id = ? and status_id = ?", client_id, status_id], :order => "due_date asc"

  end
  
  
  def setup_chase_dates
    if self.new_record? || self.due_date_changed?
      # Setup the chase dates
      @current_setting = Setting.where(user_id: self.user_id)
    
      self.pd_date = calculate_predue_date(self.due_date, @current_setting[0].days_before_pre_due)        
      self.od1_date = calculate_od1_date(self.due_date, @current_setting[0].days_between_chase)        
      self.od2_date = calculate_od2_date(self.due_date, @current_setting[0].days_between_chase)        
      self.od3_date = calculate_od3_date(self.due_date, @current_setting[0].days_between_chase)       
      self.last_date_sent = DateTime.now.to_date-100.years  
        
      if (self.status_id == 5.to_s)
        self.fd_date = Date.today+1.day
      end
    end
  end

  def calculate_predue_date(due_date, days_before)
    due_date-days_before.days
  end
  
  def calculate_od1_date(due_date, chase_days)
    due_date+chase_days.days
  end
  
  def calculate_od2_date(due_date, chase_days)
    due_date+(chase_days*2).days
  end
  
  def calculate_od3_date(due_date, chase_days)
    due_date+(chase_days*3).days
  end
  
  
  
end
