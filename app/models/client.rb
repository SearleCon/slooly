# == Schema Information
#
# Table name: clients
#
#  id             :integer          not null, primary key
#  business_name  :string
#  contact_person :string
#  address        :string(255)
#  city           :string(255)
#  post_code      :string(255)
#  telephone      :string(255)
#  fax            :string(255)
#  email          :string(255)
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Client < ActiveRecord::Base
  include AttributeNormalizer

  to_param :business_name
  

  belongs_to :user, required: true
  has_many :invoices
  has_many :outstanding_invoices, -> { merge(Invoice.chasing) }, class_name: 'Invoice'
  has_many :histories, -> { order(date_sent: :desc) }

  validates :business_name, :email, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :business_name, uniqueness: { scope: :user_id }

  before_save do
    self.business_name = business_name.titleize
    self.contact_person = contact_person.try(:titleize)
  end

  scope :search, ->(query) { where('business_name ILIKE :query or contact_person ILIKE :query', query: "#{query}%") }
end
