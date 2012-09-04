class Client < ActiveRecord::Base
  attr_accessible :address, :business_name, :city, :contact_person, :email, :fax, :post_code, :telephone, :user_id
end
