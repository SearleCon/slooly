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
  belongs_to      :user

  validates       :email, presence: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  before_validation :strip_all_spaces
  after_initialize :set_defaults, if: :new_record?

  mount_uploader :image, ImageUploader

  protected
    def strip_all_spaces
      self.email = self.email.strip
    end

    def set_defaults
     self.name = "Your Company Name"
     self.address = "44 Street Name, Suburb"
     self.city	= "Best City"
     self.post_code = "1234"
     self.telephone = "555 345 6789"
     self.fax = "People still fax?"
     self.email	= "you@example.com"
    end


  
end
