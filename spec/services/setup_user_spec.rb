describe SetupUser do
  before :each do
    @free_trial = create(:free_trial)
  end

  it 'should create the company for the user' do
    user = create(:user, company: nil)
    SetupUser.call(user)

    company = user.company

    expect(company).to_not be_nil
  end

  it 'should create the settings for the user' do
    user = create(:user, setting: nil)
    SetupUser.call(user)

    setting = user.setting

    expect(setting).to_not be_nil
  end

  describe 'subscription' do
    it 'should create the subscription for the user' do
      user = create(:user)
      SetupUser.call(user)

      subscription = user.active_subscription
      expect(subscription).to_not be_nil
    end

    it 'should be on the free trial plan' do
      user = create(:user)
      SetupUser.call(user)

      subscription = user.active_subscription
      expect(subscription.plan).to eq @free_trial
    end
  end



end