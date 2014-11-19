class UserSetup
  def initialize(user)
    @user = user
  end

  def call
    User.transaction do
      setup_company
      setup_settings
      setup_subscription
    end
  end

  private

  def setup_company
    @user.create_company!
  end

  def setup_subscription
    plan = Plan.find_by_free(true)
    @user.subscriptions.create!(plan_id: plan.id,
                                expiry_date: Time.zone.now.advance(months: plan.duration),
                                bought_on: Time.zone.now,
                                time:  "#{plan.duration} month(s)",
                                active: true)
  end

  def setup_settings
    @user.create_setting!
  end
end
