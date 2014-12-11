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

  before_create :set_expiry_date

  delegate :description, :duration, :cost, to: :plan, prefix: true

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

  def expiring_soon?
    expires_in <= 3
  end

  def payment_provided?
    paypal_payment_token.present?
  end

  private

  def set_expiry_date
    self.expiry_date = Time.zone.now.advance(months: plan.duration)
  end
end
