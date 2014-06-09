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
     expiry_date = Time.zone.now + plan.duration.months
     @user.subscriptions.create!(plan_id: plan, expiry_date: expiry_date)
   end

   def setup_settings
     @user.create_setting!
   end
end