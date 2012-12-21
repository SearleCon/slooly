class Company < ActiveRecord::Base
  attr_accessible :address, :city, :email, :fax, :logo_path, :name, :post_code, :telephone, :user_id, :image, :remote_image_url
  belongs_to      :user
  validates       :email, :presence => true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  before_validation :strip_all_spaces
  
  
  def self.by_user(user)
    where("user_id = ?", user)    
  end
  
  mount_uploader :image, ImageUploader
  
  def strip_all_spaces
    self.email = self.email.strip
  end
  
end
