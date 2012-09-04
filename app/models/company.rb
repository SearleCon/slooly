class Company < ActiveRecord::Base
  attr_accessible :address, :city, :email, :fax, :logo_path, :name, :post_code, :telephone, :user_id
  belongs_to      :user
  
  def self.by_user(user)
    where("user_id == ?", user)    
  end
end
