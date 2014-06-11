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
     @user.subscriptions.create! do |subscription|
       subscription.plan_id = plan.id
       subscription.expiry_date = Time.zone.now.advance(months: plan.duration)
       subscription.bought_on = Time.zone.now
       subscription.time =  "#{plan.duration} month(s)"
       subscription.active = true
     end
   end

   def setup_settings
     @user.create_setting!
   end
end
