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
#  time_zone              :string(255)
#

class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  has_one :company
  has_one :setting

  has_many :clients
  has_many :invoices
  has_many :histories

  has_many :subscriptions

  validates :terms_of_service, acceptance: true
  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone.zones_map.keys }

  def timeout_in
    2.hours
  end

  def subscription
    subscriptions.active.take
  end

  def subscribed?
    subscription.present? && !subscription.expired?
  end
end
