describe ClientsController do
  describe 'Get #index' do
    before do
      user = create(:subscribed_user)
      sign_in user
      get :index
    end

    it { is_expected.to respond_with :ok }
  end
end