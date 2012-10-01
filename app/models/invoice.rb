class Invoice < ActiveRecord::Base
  attr_accessible :amount, :client_id, :description, :due_date, :invoice_number, :status_id
  belongs_to      :client
  validates       :client_id, :due_date, :description, :invoice_number, :presence => true
  validates_numericality_of :amount  
  

  
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
#    @clients_invoices_chasing = Invoice.find(:all, :conditions => ["client_id = ? and status_id = ?", client_id, status_id]).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 10) 

  end
  
end
