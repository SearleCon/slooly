class PaypalPayment
  def initialize(subscription)
    @subscription = subscription
    @plan = subcription.plan
  end

  def profile_details
    process(:profile, profile_id: @subscription.paypal_recurring_profile_token)
  end

  def checkout_details
    process :checkout_details
  end

  def request_payment
    process :request_payment
  end

  def suspend
    process(:suspend, profile_id: @subscription.paypal_recurring_profile_token)
  end

  def reactivate
    process(:reactivate, profile_id: @subscription.paypal_recurring_profile_token)
  end

  def cancel
    process(:cancel,  profile_id: @subscription.paypal_recurring_profile_token)
  end

  def checkout_url(options)
    process(:checkout, options).checkout_url
  end

  def make_recurring
    process :create_recurring_profile, period: :monthly, frequency: 1, start_at: Time.zone.now
  end

  private

  def process(action, options = {})
    options = options.reverse_merge(
        token: @subscription.paypal_payment_token,
        payer_id: @subscription.paypal_customer_token,
        description: @plan.description,
        amount: @plan.cost,
        currency: 'USD'
    )
    response = PayPal::Recurring.new(options).send(action)
    fail response.errors.inspect if response.errors.present?
    response
  end
end
