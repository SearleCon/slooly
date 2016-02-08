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
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string(255)
#  time_zone              :string
#

class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  to_param :name

  has_one :company
  has_one :setting
  has_one :subscription, -> { merge(Subscription.active) }

  has_many :vouchers, foreign_key: :redeemed_by

  has_many :clients
  has_many :invoices

  validates :terms_of_service, acceptance: true
  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone.zones_map.keys }, allow_blank: true

  after_create do
    create_subscription!(plan: Plan.free_trial)
    create_company!
    create_setting!
  end

  after_commit on: :create do
    UserMailer.registration_confirmation(self).deliver_later
  end

  def send_devise_notification(notification, *args)
     devise_mailer.send(notification, self, *args).deliver_later
  end

  def subscribed?
    subscription&.active?
  end

  def timeout_in
    2.hours
  end
end
