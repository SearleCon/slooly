class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def new
   @subscription = Subscription.new(plan_id: params[:plan_id] ,paypal_customer_token: params[:token], paypal_recurring_profile_token: params[:PayerID])
  end

  def create
    @subscription = Subscription.new(subscription_params)

    if SubscribeUser.new(current_user, @subscription).perform.success?
      flash.now[:notice] = 'Thank you for supporting us!'
    else
      flash.now[:alert] = 'There has been a problem activating your subscription. Please contact support.'
      render :new
    end
  end

  private
  def subscription_params
    params.require(:subscription).permit(:plan_id, :paypal_recurring_profile_token, :paypal_customer_token).merge(user_id: current_user.id)
  end
end
