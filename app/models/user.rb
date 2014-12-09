# == Schema Information
#
# Table name: users
#
#  id                     :integer          primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :timestamp
#  remember_created_at    :timestamp
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :timestamp
#  last_sign_in_at        :timestamp
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :timestamp        not null
#  updated_at             :timestamp        not null
#  name                   :string(255)
#

class User < ActiveRecord::Base
  enum role: [:user, :admin]

  devise :database_authenticatable, :async, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  has_many :clients
  has_many :subscriptions, before_add: :deactivate_subscription, after_add: :activate_subscription
  has_many :invoices
  has_many :histories
  has_one :company
  has_one :setting

  validates :terms_of_service, acceptance: true

  after_initialize :set_default_role, if: :new_record?

  def timeout_in
    2.hours
  end

  def active_subscription
    subscriptions.active.first
  end

  protected

  def activate_subscription(subscription)
    subscription.update(active: true)
  end

  def deactivate_subscription
    active_subscription.update(active: false)
  end

  def set_default_role
    self.role ||= :user
  end

  def cancel
    false
  end
end
