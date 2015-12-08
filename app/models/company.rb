# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string(255)      default("Your Company Name")
#  address    :string(255)      default("44 Street Name, Suburb")
#  city       :string(255)      default("Best City")
#  post_code  :string(255)      default("1234")
#  telephone  :string(255)      default("555 345 6789")
#  fax        :string(255)      default("People still fax?")
#  email      :string(255)      default("you@example.com")
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Company < ActiveRecord::Base
  include AttributeNormalizer

  belongs_to :user, touch: true

  validates :email, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  before_save do
    self.name = name.try(:titleize)
  end

end
