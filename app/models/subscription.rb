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
  belongs_to :plan
  belongs_to :user

  attr_accessible :active, :bought_on, :expiry_date, :paypal_id, :plan_id, :time, :user, :paypal_customer_token, :paypal_payment_token
  attr_accessor :paypal_payment_token

  scope :active, -> { where(active: true) }

  def paypal
      PaypalPayment.new(self)
    end

    def save_with_paypal_payment
      response = paypal.request_payment
      response.approved? && response.success? ? save! : false
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
      Time.zone.now > self.expiry_date
    end

    def expires_in
      (expiry_date - Time.zone.today).to_i
    end

    def payment_provided?
      paypal_payment_token.present?
    end

end
