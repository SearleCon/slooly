class Invoice < ActiveRecord::Base
  attr_accessible :amount, :client_id, :description, :due_date, :invoice_number, :status_id
  belongs_to      :client
  
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
      where('invoice_number LIKE ? or description LIKE ?', "%#{search}%", "%#{search}%")
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
end
