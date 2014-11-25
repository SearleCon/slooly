class User::Registration

  def self.register(user)
    free_trial = Plan.find_by(free: true)
    User.transaction do
      user.create_company!
      user.create_setting!
      user.subscriptions.create!(plan: free_trial, active: true)
    end
    UserMailer.delay.registration_confirmation(@user)
  end
end
