class UserSetup

  def initialize(user)
    @user = user
  end

  def call
    User.transaction do
      setup_company
      setup_subscription
      setup_settings
    end
  end

  private
   def setup_company
     @user.create_company!
   end

   def setup_subscription
     plan = Plan.find_by_free(true)
     subscription = plan.subscriptions.create!(user: @user)
     subscription.save!
   end

   def setup_settings
     @user.create_setting!
   end
end