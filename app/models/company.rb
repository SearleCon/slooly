class Company < ActiveRecord::Base
  attr_accessible :address, :city, :email, :fax, :logo_path, :name, :post_code, :telephone, :user_id
end
