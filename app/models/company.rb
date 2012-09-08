class Company < ActiveRecord::Base
  attr_accessible :address, :city, :email, :fax, :logo_path, :name, :post_code, :telephone, :user_id, :image, :remote_image_url
  belongs_to      :user
  
  def self.by_user(user)
    where("user_id = ?", user)    
  end
  
  mount_uploader :image, ImageUploader
  
end
