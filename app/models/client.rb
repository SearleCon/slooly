# == Schema Information
#
# Table name: clients
#
#  id             :integer          primary key
#  business_name  :string(255)
#  contact_person :string(255)
#  address        :string(255)
#  city           :string(255)
#  post_code      :string(255)
#  telephone      :string(255)
#  fax            :string(255)
#  email          :string(255)
#  user_id        :integer
#  created_at     :timestamp        not null
#  updated_at     :timestamp        not null
#

class Client < ActiveRecord::Base
  attr_accessible :address, :business_name, :city, :contact_person, :email, :fax, :post_code, :telephone, :user_id
  has_many        :invoices, :dependent => :destroy
  belongs_to      :user
  accepts_nested_attributes_for :invoices #SS - To allow managing of invoices through clients
  validates       :business_name, :email, :presence => true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_uniqueness_of :business_name, :scope => [:user_id]
  before_validation :strip_all_spaces

  include Importable
  
  
  #SS Defined by you (user is the variable passed in from the controller - See ClientsController index action)  
  def self.for_user(user) 
      where("user_id = ?", user)
  end

    
  def self.search(search)
    if search
      where('LOWER(business_name) LIKE ? or LOWER(contact_person) LIKE ?', "%#{search}%".downcase, "%#{search}%".downcase)
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
  
  def strip_all_spaces
    self.email = self.email.strip
  end
  
end
