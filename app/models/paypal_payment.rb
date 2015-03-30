class PaypalPayment
  def initialize(subscription)
    @subscription = subscription
    @plan = subcription.plan
  end


  def request_payment
    PayPal::Recurring.new({token: @subscription.paypal_payment_token,
                           payer_id: @subscription.paypal_customer_token,
                           description: @plan.description,
                           amount: @plan.cost,
                           currency: 'USD'}).request_payment

  end

  def checkout_url(options)
    response = PayPal::Recurring.new({token: @subscription.paypal_payment_token,
                           payer_id: @subscription.paypal_customer_token,
                           description: @plan.description,
                           amount: @plan.cost,
                           currency: 'USD'}).checkout
    response.checkout_url
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
