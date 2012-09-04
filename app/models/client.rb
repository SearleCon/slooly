class Client < ActiveRecord::Base
  attr_accessible :address, :business_name, :city, :contact_person, :email, :fax, :post_code, :telephone, :user_id
  has_many        :invoices
  belongs_to      :user
  
  #SS Defined by you (user is the variable passed in from the controller - See ClientsController index action)  
  def self.for_user(user) 
      where("user_id = ?", user)
  end
end