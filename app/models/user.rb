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
  rolify

  devise :database_authenticatable, :async, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  has_many :clients, inverse_of: :user, dependent: :destroy
  has_many :subscriptions, inverse_of: :user, dependent: :destroy
  has_many :invoices, inverse_of: :user, dependent: :destroy
  has_many :histories, inverse_of: :user, dependent: :destroy
  has_one :company, dependent: :destroy
  has_one :setting, dependent: :destroy

  validates :terms_of_service, acceptance: true

  def timeout_in
    2.hours
  end

  def active_subscription
    subscriptions.active.first
  end

  protected

  def cancel
    false
  end
end
