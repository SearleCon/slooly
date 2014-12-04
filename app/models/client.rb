# == Schema Information
#
# Table name: clients
#
#  id             :integer          primary key
#  business_name  :string(255)
#  contact_person :string(255)
#  address        :string(255)
#  city           :string(255)
#  post_code      :string(255)
#  telephone      :string(255)
#  fax            :string(255)
#  email          :string(255)
#  user_id        :integer
#  created_at     :timestamp        not null
#  updated_at     :timestamp        not null
#

class Client < ActiveRecord::Base
  self.per_page = 10

  belongs_to :user, touch: true
  has_many :invoices
  has_many :invoices_chasing, -> { where(status_id: Invoice::STATUSES[:chasing]) }, class_name: 'Invoice'
  has_many :histories, -> { order('date_sent desc') }

  validates :business_name, :email, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :business_name, uniqueness: { scope: :user_id }

  before_save :normalize_data

  protected

  def normalize_data
    self.business_name = business_name.strip if business_name
    self.email = email.strip if email
  end
end
