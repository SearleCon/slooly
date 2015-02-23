class Admins::Users::SubscriptionsController < Admins::BaseController
  before_action :set_user
  before_action :set_subscription

  def edit
  end

  def update
    flash[:notice] = t('flash.users.subscriptions.update', name: @user.name) if @subscription.update(subscription_params)
    respond_with @subscription, location: admin_user_url(@user)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_subscription
    @subscription = @user.subscriptions.find(params[:id])
  end

  def subscription_params
    params.require(:subscription).permit(:expiry_date)
  end
end
