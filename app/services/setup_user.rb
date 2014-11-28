class SetupUser
  include Service

  def initialize(user)
    @user = user
  end

  def call
    User.transaction do
      @user.create_company!
      @user.create_setting!
      @user.subscriptions.create!(plan: free_trial, active: true)
    end
    UserMailer.delay.registration_confirmation(@user)
  end

  private

  def free_trial
    @free_trial ||= Plan.find_by(free: true)
  end
end
