class Subscription < ActiveRecord::Base
  belongs_to :plan
  attr_accessible :active, :bought_on, :expiry_date, :paypal_id, :plan_id, :time, :user_id, :paypal_customer_token, :paypal_payment_token
  attr_accessor :paypal_payment_token

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
      Time.now > self.expiry_date
    end

    def payment_provided?
      paypal_payment_token.present?
    end

end
