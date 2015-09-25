# == Schema Information
#
# Table name: clients
#
#  id             :integer          not null, primary key
#  business_name  :string(255)
#  contact_person :string(255)
#  address        :string(255)
#  city           :string(255)
#  post_code      :string(255)
#  telephone      :string(255)
#  fax            :string(255)
#  email          :string(255)
#  user_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Client < ActiveRecord::Base

  to_param :business_name

  belongs_to :user
  has_many :invoices
  has_many :histories, -> { order(date_sent: :desc) }

  validates :business_name, :email, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :business_name, uniqueness: { scope: :user_id }

  scope :search, ->(query) { where('business_name ILIKE :query or contact_person ILIKE :query', query: "#{query}%") }

  def business_name=(value)
    value.strip! if value
    super(value)
  end

  def email=(value)
    value.strip! if value
    super(value)
  end
end
