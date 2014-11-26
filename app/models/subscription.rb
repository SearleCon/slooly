# == Schema Information
#
# Table name: subscriptions
#
#  id                             :integer          primary key
#  bought_on                      :timestamp
#  plan_id                        :integer
#  expiry_date                    :date
#  time                           :string(255)
#  active                         :boolean
#  paypal_id                      :string(255)
#  user_id                        :integer
#  created_at                     :timestamp        not null
#  updated_at                     :timestamp        not null
#  paypal_customer_token          :string(255)
#  paypal_recurring_profile_token :string(255)
#

class Subscription < ActiveRecord::Base
  belongs_to :plan, touch: true
  belongs_to :user, touch: true

  attr_accessor :paypal_payment_token

  scope :active, -> { where(active: true) }

  after_initialize :setup_defaults, if: :new_record?
  before_create :setup_expiry_date
  before_create :setup_time

  def paypal
    PaypalPayment.new(self)
  end

  def save_with_paypal_payment
    response = paypal.request_payment
    response.approved? && response.success? && save
  end

  def cancel
    response = paypal.cancel
    response.success?
  end

  def reactivate
    response = paypal.reactivate
    response.success?
  end

  def has_expired?
    Time.zone.now > expiry_date
  end

  def expires_in
    (expiry_date - Time.zone.today).to_i
  end

  def payment_provided?
    paypal_payment_token.present?
  end

  private

  def setup_defaults
    self.bought_on = Time.zone.now
  end

  def setup_expiry_date
    self.expiry_date = Time.zone.now.advance(months: plan.duration)
  end

  def setup_time
    self.time = "#{plan.duration} month(s)"
  end
end
