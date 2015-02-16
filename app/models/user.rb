# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  role                   :integer          default(0)
#  time_zone              :string(255)
#

class User < ActiveRecord::Base
  enum role: [:user, :admin]

  devise :database_authenticatable, :async, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  has_many :clients
  has_many :invoices
  has_many :subscriptions, before_add: :activate_subscription
  has_many :histories
  has_one :company
  has_one :setting

  validates :terms_of_service, acceptance: true
  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone.zones_map.keys }

  delegate :expiry_date, :expiring_soon?, :expires_in, :has_expired?, to: :subscription, allow_nil: true, prefix: true

  def timeout_in
    2.hours
  end

  def subscription
    subscriptions.active.first
  end

  protected

  def activate_subscription(new_subscription)
    current_subscription.update(active: false) if current_subscription.present?
    new_subscription.active = true
  end
end
