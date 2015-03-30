# == Schema Information
#
# Table name: subscriptions
#
#  id                             :integer          not null, primary key
#  plan_id                        :integer
#  expiry_date                    :date
#  active                         :boolean
#  user_id                        :integer
#  created_at                     :datetime
#  updated_at                     :datetime
#  paypal_customer_token          :string(255)
#  paypal_recurring_profile_token :string(255)
#

class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :user, touch: true

  attr_accessor :paypal_payment_token

  validates :plan, :user, presence: true

  scope :active, -> { where(active: true) }

  delegate :description, :duration, :cost, to: :plan, prefix: true


  after_initialize :expire, unless: :new_record?
  before_create :set_expiry_date


  def paypal
    PaypalPayment.new(self)
  end

  def save_with_paypal_payment
    response = paypal.request_payment
    self.active = true
    response.approved? && response.success? && save
  end

  def payment_provided?
    paypal_payment_token.present?
  end

  private
  def expire
    update(active: false) if active? && Date.current > expiry_date
  end

  def set_expiry_date
    self.expiry_date = Date.current.advance(months: plan_duration)
  end
end
