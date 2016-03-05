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
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Client < ActiveRecord::Base
  include AttributeNormalizer, CollectionCacheable

  to_param :business_name

  belongs_to :user, required: true
  has_many :invoices
  has_many :outstanding_invoices, -> { merge(Invoice.chasing) }, class_name: 'Invoice'
  has_many :histories, -> { order(date_sent: :desc) }, through: :invoices

  validates :business_name, :email, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :business_name, uniqueness: { scope: :user_id }

  def self.cache_key
    model_signature = model_name.cache_key
    unique_signature = if current_scope.loaded?
                         pluck(collection.primary_key, :updated_at).flatten.join('-')
                       else
                         unscope(:order).pluck(primary_key, :updated_at).flatten.join('-')
                       end
    "#{model_signature}/collection-digest-#{Digest::SHA256.hexdigest(unique_signature)}"

  end
end
