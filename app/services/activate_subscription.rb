class ActivateSubscription
  def initialize(user, subscription)
    @user = user
    @subscription = subscription
  end

  def call
    Subscription.transaction do
      deactivate_current!
      activate_new!
    end
  end

  private

  def deactivate_current!
    @user.active_subscription.update!(active: false)
  end

  def activate_new!
    @subscription.update!(active: true)
  end
end
