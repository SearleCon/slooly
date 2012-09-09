class Client < ActiveRecord::Base
  attr_accessible :address, :business_name, :city, :contact_person, :email, :fax, :post_code, :telephone, :user_id
  has_many        :invoices, :dependent => :destroy
  belongs_to      :user
  accepts_nested_attributes_for :invoices #SS - To allow managing of invoices through clients
  
  #SS Defined by you (user is the variable passed in from the controller - See ClientsController index action)  
  def self.for_user(user) 
      where("user_id = ?", user)
  end
  
  def self.search(search)
    if search
      where('business_name LIKE ? or contact_person LIKE ?', "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end
  
end