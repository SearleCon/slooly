class SubscribeUser
  include Service

  def initialize(user, subscription)
    @user, @subscription = user, subscription
  end

  def perform
    Subscription.transaction do
      raise ActiveRecord::Rollback unless request_payment && subscription.save
    end
  end

  def success?
    subscription.persisted?
  end

  private

  attr_reader :user, :subscription

  def request_payment
    response = PayPal::Recurring.new(token: subscription.paypal_customer_token, payer_id: subscription.paypal_recurring_profile_token, description: subscription.description, amount: subscription.cost, currency: 'USD').request_payment
    response.approved? && response.completed?
  end
end
