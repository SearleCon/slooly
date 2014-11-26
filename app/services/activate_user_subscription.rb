class ActivateUserSubscription
  attr_reader :subscription
  def initialize(subscription, user)
    @subscription = subscription
    @user = user
  end

  def call
    Subscription.transaction do
      begin
        previous_subscription.update!(active: false)
        subscription.update!(active: true)
      rescue
        raise ActivateSubscriptionForUserFailed
      end
    end
  end

  private

  def previous_subscription
    @previous_subscription ||= @user.active_subscription
  end
end

class ActivateUserSubscriptionFailed < Exception; end
