# == Schema Information
#
# Table name: companies
#
#  id         :integer          primary key
#  name       :string(255)
#  logo_path  :string(255)
#  address    :string(255)
#  city       :string(255)
#  post_code  :string(255)
#  telephone  :string(255)
#  fax        :string(255)
#  email      :string(255)
#  user_id    :integer
#  created_at :timestamp        not null
#  updated_at :timestamp        not null
#  image      :string(255)
#

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
