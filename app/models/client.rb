class Client < ActiveRecord::Base
  attr_accessible :address, :business_name, :city, :contact_person, :email, :fax, :post_code, :telephone, :user_id
  has_many        :invoices, :dependent => :destroy
  belongs_to      :user
  accepts_nested_attributes_for :invoices #SS - To allow managing of invoices through clients
  validates       :business_name, :email, :presence => true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  
  
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
  
  def self.total_chasing_outstanding(client_id)
    @clients_chasing = Invoice.all :conditions => ["client_id = ? and status_id = ?", client_id, 2]
    @total_chasing = 0
    @clients_chasing.each do |c|
      @total_chasing = @total_chasing + c.amount
    end
    return @total_chasing
  end  
  
end