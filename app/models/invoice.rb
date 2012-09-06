class Invoice < ActiveRecord::Base
  attr_accessible :amount, :client_id, :description, :due_date, :invoice_number, :status_id
  belongs_to      :client
  
#  delegate :business_name, :to => :client, :prefix => true
  
  def self.for_user(user) 
      where("user_id = ?", user)
  end  

  def self.for_client(client) 
      where("client_id = ?", client)
  end
end
