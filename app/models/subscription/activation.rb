class Subscription::Activation
  def self.activate(user, subscription)
    Subscription.transaction do
      user.active_subscription.update(active: false)
      subscription.update(active: true)
    end
  end
end